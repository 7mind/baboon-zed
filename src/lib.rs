use zed_extension_api::{self as zed, settings::LspSettings, Command, LanguageServerId, Result, Worktree};

struct BaboonExtension;

impl zed::Extension for BaboonExtension {
    fn new() -> Self {
        BaboonExtension
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &Worktree,
    ) -> Result<Command> {
        let lsp_settings = LspSettings::for_worktree(language_server_id.as_ref(), worktree)?;

        // Determine binary path: configured path, then PATH lookup
        let binary_path = lsp_settings
            .binary
            .as_ref()
            .and_then(|b| b.path.clone())
            .or_else(|| worktree.which("baboon"))
            .ok_or_else(|| {
                "baboon executable not found. \
                 Either add it to PATH or configure lsp.baboon.binary.path in settings"
                    .to_string()
            })?;

        // Get configured arguments or build default ones
        let args = if let Some(ref binary) = lsp_settings.binary {
            if let Some(ref arguments) = binary.arguments {
                arguments.clone()
            } else {
                self.default_args(worktree, &lsp_settings)
            }
        } else {
            self.default_args(worktree, &lsp_settings)
        };

        // Get environment variables if configured
        let env = lsp_settings
            .binary
            .as_ref()
            .and_then(|b| b.env.clone())
            .unwrap_or_default();

        Ok(Command {
            command: binary_path,
            args,
            env,
        })
    }
}

impl BaboonExtension {
    fn default_args(&self, worktree: &Worktree, lsp_settings: &LspSettings) -> Vec<String> {
        let mut args = Vec::new();

        // Try to get model_dirs from settings, otherwise use workspace root
        let model_dirs: Vec<String> = lsp_settings
            .settings
            .as_ref()
            .and_then(|s| s.get("model_dirs"))
            .and_then(|v| serde_json::from_value(v.clone()).ok())
            .unwrap_or_else(|| vec![worktree.root_path()]);

        for dir in model_dirs {
            args.push("--model-dir".to_string());
            args.push(dir);
        }

        args.push(":lsp".to_string());
        args
    }
}

zed::register_extension!(BaboonExtension);
