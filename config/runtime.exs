# use Mix.Config
import Config

DotenvParser.load_file(".env")

config :hd_plus_ussd, HdPlusUssd.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("DATABASE_NAME1"),
  username: System.get_env("DATABASE_USER1"),
  password: System.get_env("DATABASE_PASSWORD1"),
  hostname: System.get_env("DATABASE_HOST1"),
  pool_size: 2,
  port: System.get_env("DATABASE_PORT1")

