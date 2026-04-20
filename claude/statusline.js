#!/usr/bin/env node

const { execSync } = require('child_process');
const os = require('os');

const chunks = [];
process.stdin.on('data', chunk => chunks.push(chunk));
process.stdin.on('end', () => {
  let data;
  try {
    data = JSON.parse(Buffer.concat(chunks).toString());
  } catch {
    process.stdout.write('\n');
    return;
  }

  const R    = '\x1b[0m';
  const B    = '\x1b[1m';
  const D    = '\x1b[37m';
  const cyan = '\x1b[36m';
  const blue = '\x1b[34m';
  const mag  = '\x1b[35m';
  const yel  = '\x1b[33m';
  const grn  = '\x1b[32m';
  const red  = '\x1b[31m';

  const strip = s => s.replace(/\x1b\[[0-9;]*m/g, '');

  const modelId  = (data.model?.id ?? 'unknown').replace('claude-', '');
  const ctxPct   = data.context_window?.used_percentage ?? 0;
  const totalIn  = data.context_window?.total_input_tokens  ?? 0;
  const totalOut = data.context_window?.total_output_tokens ?? 0;
  const cost     = data.cost?.total_cost_usd ?? 0;
  const durMs    = data.cost?.total_duration_ms ?? 0;
  const cwd      = data.cwd ?? data.workspace?.current_dir ?? process.cwd();

  const fmt = n =>
    n >= 1_000_000 ? `${(n / 1_000_000).toFixed(1)}M` :
    n >= 1_000     ? `${Math.round(n / 1_000)}k` : `${n}`;

  const fmtDur = ms => {
    const s = Math.floor(ms / 1000);
    if (s < 60)  return `${s}s`;
    const m = Math.floor(s / 60);
    if (m < 60)  return `${m}m${String(s % 60).padStart(2, '0')}s`;
    const h = Math.floor(m / 60);
    return `${h}h${String(m % 60).padStart(2, '0')}m`;
  };

  // CWD: abbreviate home to ~
  const home       = os.homedir();
  const cwdDisplay = cwd.startsWith(home) ? '~' + cwd.slice(home.length) : cwd;

  // Git branch + dirty flag
  let gitBranch = '';
  let gitDirty  = false;
  try {
    gitBranch = execSync(`git -C "${cwd}" rev-parse --abbrev-ref HEAD`, {
      encoding: 'utf8', timeout: 2000, stdio: ['ignore', 'pipe', 'ignore'],
    }).trim();
    const st = execSync(`git -C "${cwd}" status --porcelain -uno`, {
      encoding: 'utf8', timeout: 2000, stdio: ['ignore', 'pipe', 'ignore'],
    }).trim();
    gitDirty = st.length > 0;
  } catch { /* not a git repo */ }

  // Gradient bar — background colors + spaces
  const BAR_WIDTH = 26;
  const filled = Math.round((ctxPct / 100) * BAR_WIDTH);
  let bar = '';
  for (let i = 0; i < BAR_WIDTH; i++) {
    const pos = (i / BAR_WIDTH) * 100;
    bar += i < filled
      ? (pos < 60 ? '\x1b[42m' : pos < 80 ? '\x1b[43m' : '\x1b[41m') + ' ' + R
      : '\x1b[100m' + ' ' + R;
  }

  const pctColor = ctxPct < 60 ? grn : ctxPct < 80 ? yel : red;

  const SEP     = ` ${D}│${R} `;
  const lbl     = t => `${D}${t}:${R} `;
  const badge   = content => `${D}<${R}${content}${D}>${R}`;
  const ctxSize = data.context_window?.context_window_size ?? 0;

  // Line 1 — location + metrics, left-flushed, each entry badged
  const line1 = [
    gitBranch ? badge(`${lbl('branch')}${grn}${gitBranch}${R}${gitDirty ? ` ${yel}●${R}` : ''}`) : '',
    badge(`${lbl('cwd')}${D}${cwdDisplay}${R}`),
    badge(`${lbl('in')}${blue}${fmt(totalIn)}${R}`),
    badge(`${lbl('out')}${mag}${fmt(totalOut)}${R}`),
    badge(`${lbl('cost')}${yel}$${cost.toFixed(2)}${R}`),
    badge(`${lbl('time')}${D}${fmtDur(durMs)}${R}`),
  ].filter(Boolean).join(SEP);

  // Line 2 — model + context bar, left-flushed, each entry badged
  const line2 = [
    badge(`${lbl('model')}${cyan}${B}${modelId}${R}`),
    ctxSize ? badge(`${lbl('limit')}${D}${fmt(ctxSize)}${R}`) : '',
    badge(`${lbl('ctx')}${bar}${pctColor}${B} ${ctxPct}%${R}`),
  ].filter(Boolean).join(SEP);

  process.stdout.write(line1 + '\n' + line2 + '\n');
});
