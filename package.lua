  return {
    name = "UrNightmaree/tluvit",
    version = "2.0",
    description = "A Teal (.tl) loader for Luvit Runtime",
    tags = { "luvit", "loader", "teal" },
    license = "MIT",
    author = "UrNightmaree",
    homepage = "https://github.com/UrNightmaree/tluvit",
    dependencies = {
			"truemedian/import",
			"luvit/fs",
			"luvit/require"
		},
    files = {
      "**.lua",
      "!test*"
    }
  }
  
