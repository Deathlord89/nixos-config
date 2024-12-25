{
  services = {
    tandoor-recipes = {
      enable = true;
      address = "0.0.0.0";
      port = 8082;
      extraConfig = {
        # ALLOWED_HOSTS=recipes.mydomain.com
        DB_ENGINE = "django.db.backends.postgresql";
        POSTGRES_DB = "tandoor_recipes";
        POSTGRES_USER = "tandoor_recipes";
        POSTGRES_HOST = "/run/postgresql";
      };
    };

    postgresql = {
      ensureUsers = [
        {
          name = "tandoor_recipes";
          ensureDBOwnership = true;
        }
      ];
      ensureDatabases = ["tandoor_recipes"];
    };
  };

  networking.firewall.allowedTCPPorts = [8082];
}
