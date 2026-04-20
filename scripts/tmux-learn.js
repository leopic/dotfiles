#!/usr/bin/env node

const readline = require('readline');
const fs = require('fs');
const os = require('os');

const SAVE_FILE = `${os.homedir()}/.tmux-learn.json`;

const BINDINGS = [
  { key: 'Ctrl+b c',    action: 'new window'                  },
  { key: 'Ctrl+b ,',    action: 'rename window'                },
  { key: 'Ctrl+b n',    action: 'next window'                  },
  { key: 'Ctrl+b p',    action: 'previous window'              },
  { key: 'Ctrl+b w',    action: 'list windows'                 },
  { key: 'Ctrl+b %',    action: 'split pane vertically'        },
  { key: 'Ctrl+b "',    action: 'split pane horizontally'      },
  { key: 'Ctrl+b →',    action: 'move to pane right'           },
  { key: 'Ctrl+b ←',    action: 'move to pane left'            },
  { key: 'Ctrl+b ↑',    action: 'move to pane above'           },
  { key: 'Ctrl+b ↓',    action: 'move to pane below'           },
  { key: 'Ctrl+b z',    action: 'zoom / unzoom pane'           },
  { key: 'Ctrl+b x',    action: 'close current pane'           },
  { key: 'Ctrl+b d',    action: 'detach from session'          },
  { key: 'Ctrl+b s',    action: 'list sessions'                },
  { key: 'Ctrl+b $',    action: 'rename session'               },
  { key: 'Ctrl+b [',    action: 'enter scroll / copy mode'     },
  { key: 'Ctrl+b ]',    action: 'paste from buffer'            },
  { key: 'Ctrl+b t',    action: 'show clock'                   },
  { key: 'Ctrl+b ?',    action: 'list all keybindings'         },
];

const R  = '\x1b[0m';
const B  = '\x1b[1m';
const D  = '\x1b[2m';
const grn = '\x1b[32m';
const red = '\x1b[31m';
const yel = '\x1b[33m';
const cyn = '\x1b[36m';
const mag = '\x1b[35m';

function load() {
  try { return JSON.parse(fs.readFileSync(SAVE_FILE, 'utf8')); } catch { return {}; }
}

function save(progress) {
  fs.writeFileSync(SAVE_FILE, JSON.stringify(progress, null, 2));
}

function normalize(s) {
  return s.trim().toLowerCase().replace(/\s+/g, ' ');
}

function pick(progress) {
  // Weight: unseen > wrong > correct. Never fully graduate a binding.
  const weighted = BINDINGS.flatMap(b => {
    const p = progress[b.key] ?? { correct: 0, wrong: 0 };
    const weight = p.wrong > 0 ? 4 : p.correct === 0 ? 3 : 1;
    return Array(weight).fill(b);
  });
  return weighted[Math.floor(Math.random() * weighted.length)];
}

function renderProgress(progress) {
  const total   = BINDINGS.length;
  const seen    = BINDINGS.filter(b => progress[b.key]).length;
  const mastered = BINDINGS.filter(b => (progress[b.key]?.correct ?? 0) >= 3 && (progress[b.key]?.wrong ?? 0) === 0).length;
  const BAR = 20;
  const fill = Math.round((mastered / total) * BAR);
  const bar  = `${grn}${'█'.repeat(fill)}${D}${'░'.repeat(BAR - fill)}${R}`;
  console.log(`\n  ${D}progress${R}  ${bar}  ${B}${mastered}${R}${D}/${total} mastered${R}   ${D}seen: ${seen}/${total}${R}\n`);
}

function renderStats(progress, key) {
  const p = progress[key] ?? { correct: 0, wrong: 0 };
  const streak = p.correct >= 3 && p.wrong === 0 ? ` ${grn}★ mastered${R}` : '';
  return `${D}this binding: ${grn}${p.correct}✓${R} ${D}/ ${red}${p.wrong}✗${R}${streak}`;
}

async function run() {
  const progress = load();

  const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
  const ask = q => new Promise(res => rl.question(q, res));

  console.clear();
  console.log(`\n  ${cyn}${B}tmux keybinding trainer${R}  ${D}type the key for each action, or 'q' to quit${R}\n`);
  renderProgress(progress);

  let sessionCorrect = 0;
  let sessionWrong = 0;

  while (true) {
    const binding = pick(progress);
    const prompt = `  ${B}${binding.action}${R}\n  ${D}>${R} `;
    const answer = await ask(prompt);

    if (normalize(answer) === 'q') break;

    const correct = normalize(answer) === normalize(binding.key);
    if (!progress[binding.key]) progress[binding.key] = { correct: 0, wrong: 0 };

    if (correct) {
      progress[binding.key].correct++;
      sessionCorrect++;
      console.log(`  ${grn}${B}✓ correct${R}   ${renderStats(progress, binding.key)}\n`);
    } else {
      progress[binding.key].wrong++;
      sessionWrong++;
      console.log(`  ${red}${B}✗ wrong${R}   answer: ${yel}${binding.key}${R}   ${renderStats(progress, binding.key)}\n`);
    }

    save(progress);
  }

  console.log(`\n  ${B}session:${R} ${grn}${sessionCorrect} correct${R}  ${red}${sessionWrong} wrong${R}`);
  renderProgress(progress);
  rl.close();
}

run();
