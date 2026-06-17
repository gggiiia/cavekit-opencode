import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { mkdirSync, readFileSync, writeFileSync, existsSync, readdirSync, statSync } from 'node:fs';
import os from 'node:os';

const here = dirname(fileURLToPath(import.meta.url));

function opencodeConfigDir() {
  if (process.env.XDG_CONFIG_HOME) {
    return join(process.env.XDG_CONFIG_HOME, 'opencode');
  }
  return join(os.homedir(), '.config', 'opencode');
}

function copyDir(src, dst) {
  if (!existsSync(src)) return;
  mkdirSync(dst, { recursive: true });
  for (const entry of readdirSync(src)) {
    const s = join(src, entry);
    const d = join(dst, entry);
    if (statSync(s).isDirectory()) {
      copyDir(s, d);
    } else {
      writeFileSync(d, readFileSync(s, 'utf8'));
    }
  }
}

function installFiles() {
  const configDir = opencodeConfigDir();

  const cmdDir = join(configDir, 'commands');
  copyDir(join(here, 'commands'), cmdDir);

  const skillDir = join(configDir, 'skills');
  copyDir(join(here, 'skills'), skillDir);
}

export default async () => {
  installFiles();

  return {};
};
