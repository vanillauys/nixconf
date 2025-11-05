{
  config,
  pkgs,
  ...
}: {
  home.file.".grok/user-settings.json".text = builtins.toJSON {
    apiKey = "op://personal/grok_api_key/credential";
    baseURL = "https://api.x.ai/v1";
    defaultModel = "grok-4-fast-reasoning";
    models = [
      "grok-code-fast-1"
      "grok-4-latest"
      "grok-3-latest"
      "grok-3-fast"
      "grok-3-mini-fast"
    ];
  };
}
