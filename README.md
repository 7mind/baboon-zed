# Baboon DML Extension for Zed

Zed editor extension providing support for [Baboon](https://github.com/7mind/baboon) Domain Modeling Language.

## Features

- **Syntax Highlighting**: Full Tree-sitter grammar for Baboon DML
- **LSP Integration**: Diagnostics, go-to-definition, hover, completion via Baboon compiler
- **Document Outline**: Navigate types, services, and namespaces
- **Auto-indentation**: Smart indentation for Baboon constructs
- **Bracket Matching**: Automatic bracket pairing

## Supported File Extensions

- `.baboon`
- `.bmo`

## Requirements

The Baboon compiler must be installed and available for LSP features:

```bash
# The baboon executable must be in PATH, or configured in settings
baboon --version
```

## Configuration

Configure the LSP in your Zed settings (`settings.json`):

```json
{
  "lsp": {
    "baboon": {
      "binary": {
        "path": "/path/to/baboon"
      },
      "settings": {
        "model_dirs": ["./models", "./schemas"]
      }
    }
  }
}
```

### Settings

| Setting | Description | Default |
|---------|-------------|---------|
| `binary.path` | Path to baboon executable | Searches `PATH` |
| `binary.arguments` | Custom CLI arguments | `--model-dir <workspace> :lsp` |
| `settings.model_dirs` | Model directories for LSP | Workspace root |

## Installation

### From Zed Extensions

1. Open Zed
2. Open Extensions (Cmd+Shift+X / Ctrl+Shift+X)
3. Search for "Baboon"
4. Click Install

### Development

```bash
# Clone the repository
git clone https://github.com/7mind/baboon-zed.git
cd baboon-zed

# Generate Tree-sitter parser (requires node and tree-sitter-cli)
cd grammars/baboon
tree-sitter generate
cd ../..

# Install as dev extension in Zed
# Use "Install Dev Extension" command and select this directory
```

## Language Features

### Syntax Support

- Model declarations: `model`, `version`, `include`, `import`
- Type definitions: `data`, `struct`, `adt`, `enum`, `contract`, `foreign`
- Services: `service`, `def`
- Namespaces: `ns`
- Derivations: `derived[json]`, `was[OldType]`
- Structural operators: `+` (union), `-` (removal), `^` (intersection)
- Generic types: `opt[T]`, `lst[T]`, `set[T]`, `map[K, V]`

### Example

```baboon
model acme.billing
version "1.0.0"

root data Invoice: derived[json] {
  id: uid
  items: lst[LineItem]
  total: i64
}

data LineItem {
  sku: str
  quantity: u32
  price: i64
}

root service BillingService {
  def createInvoice (
    in = Invoice
    out = uid
    err = str
  )
}
```

## License

MIT
