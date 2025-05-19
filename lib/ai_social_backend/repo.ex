defmodule AiSocialBackend.Repo do
  use Ecto.Repo,
    otp_app: :ai_social_backend,
    adapter: Ecto.Adapters.Postgres
end
