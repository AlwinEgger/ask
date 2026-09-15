# ask - AI CLI tool

A lightweight bash script for querying AI models via the Infomaniak API, optimized for direct, executable output.

## Quick start

```bash
# Clone and setup
git clone https://github.com/kagisearch/ask.git
cd ask

chmod +x ask
sudo cp ask /usr/local/bin/

# Ensure you have an opencode config with Infomaniak provider at:
# ~/.config/opencode/opencode.json
# Or set OPENCODE_CONFIG to point to your config file.

# Test it
> ask remove lines in file1 that appear in file2

grep -vFf file2 file1 > file3 && mv file3 file1

[moonshotai/Kimi-K2.6 - 0.66s - 20.9 tok/s]
```

We also provide a handy install script.

## Configuration

`ask` reads API credentials from your opencode configuration file. No credentials are stored in this repository.

### Default config location

```bash
~/.config/opencode/opencode.json
```

The Infomaniak provider must be configured with `baseURL` and `apiKey`:

```json
{
  "provider": {
    "infomaniak": {
      "options": {
        "baseURL": "https://api.infomaniak.com/2/ai/<project-id>/openai/v1",
        "apiKey": "your-api-key"
      }
    }
  }
}
```

### Custom config path

```bash
export OPENCODE_CONFIG=/path/to/your/opencode.json
```

## Usage

### Basic usage

```bash
ask ffmpeg command to convert mp4 to gif
```

### Model selection

```bash
# Default model (Kimi K2.6 - long context)
ask find files larger than 20mb

# Shorthand flags for quick model switching
ask -c "prompt"  # NVIDIA Nemotron 3 Nano (fast)
ask -g "prompt"  # Mistral Small 4 (general purpose)
ask -s "prompt"  # Apertus 70B (complex reasoning)
ask -x "prompt"  # Kimi K2.6 (default, long context)
ask -d "prompt"  # Qwen 3.5 122B (deep reasoning)
ask -q "prompt"  # Qwen 3.5 122B (qwen)
ask -o "prompt"  # Apertus 70B (open)

# Custom model by full name
ask -m "Qwen/Qwen3-Embedding-8B" "Explain this concept"
```

### System prompts

```bash
# Custom system prompt
ask --system "You are a pirate" "Tell me about sailing"

# Disable system prompt for raw model behavior
ask -r "What is 2+2?"
```

### Streaming mode

Get responses as they're generated:

```bash
ask --stream "Tell me a long story"
```

### Pipe input

```bash
echo "Fix this code: print('hello world)" | ask
cat script.py | ask "Review this code"
```

## Options

| Option | Description |
|--------|-------------|
| `-c` | Use NVIDIA Nemotron 3 Nano (fast) |
| `-g` | Use Mistral Small 4 (general) |
| `-s` | Use Apertus 70B (strong) |
| `-x` | Use Kimi K2.6 (default, long context) |
| `-d` | Use Qwen 3.5 122B (deep) |
| `-q` | Use Qwen 3.5 122B (qwen) |
| `-o` | Use Apertus 70B (open) |
| `-m MODEL` | Use custom model |
| `-r` | Disable system prompt |
| `--stream` | Enable streaming output |
| `--system` | Set custom system prompt |
| `-h, --help` | Show help message |

## Common use cases

### Command generation
```bash
# Get executable commands directly
ask "Command to find files larger than 100MB"
# Output: find . -type f -size +100M

ask "ffmpeg command to convert mp4 to gif"
# Output: ffmpeg -i input.mp4 -vf "fps=10,scale=320:-1:flags=lanczos" output.gif
```

### Code generation
```bash
# Generate code snippets
ask "Python function to calculate factorial"

# Code review
cat script.py | ask "Find potential bugs in this code"
```

### Quick answers
```bash
# Calculations
ask "What is 18% of 2450?"
# Output: 441

# Technical questions
ask "What port does PostgreSQL use?"
# Output: 5432
```

### Advanced usage
```bash
# Chain commands
ask "List all Python files" | ask "Generate a script to check syntax of these files"

# Use with other tools
docker ps -a | ask "Which containers are using the most memory?"

```

## Requirements

### Dependencies
- `bash` - Shell interpreter
- `curl` - HTTP requests to Infomaniak API
- `jq` - JSON parsing for API responses and config reading
- `bc` - Performance metrics calculation

### API access
- Infomaniak AI API key (configure in your opencode config)
- Config location: `~/.config/opencode/opencode.json` (or `OPENCODE_CONFIG`)

## License

MIT
