Rails.application.config.session_store :cache_store, expire_after: 30.minutes
Rails.application.config.middleware.use ActionDispatch::Session::CookieStore