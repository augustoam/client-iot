JWTSessions.algorithm = 'HS256'
JWTSessions.encryption_key = Rails.application.secrets.secret_jwt_encryption_key
JWTSessions.access_exp_time  = 604_800
JWTSessions.refresh_exp_time = 604_800
JWTSessions.token_store = :redis, {
  redis_host: 'localhost',
  redis_port: '6379',
  redis_db_name: '0',
  token_prefix: 'jwt_'
}
