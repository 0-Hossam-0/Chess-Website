import { registerAs } from '@nestjs/config';
import ms, { StringValue } from 'ms';

export default registerAs('refreshToken', () => ({
  cookieKey: process.env.REFRESH_TOKEN_KEY!,
  path: '/api/auth/refresh',
  salt: Number(process.env.REFRESH_TOKEN_HASHING_SALT!),
  key: process.env.REFRESH_TOKEN_KEY!,
  signOptions: {
    secret: process.env.REFRESH_TOKEN_SECRET!,
    expiresIn: ms(process.env.REFRESH_TOKEN_EXPIRE_IN! as StringValue) / 1000,
  },
}));
