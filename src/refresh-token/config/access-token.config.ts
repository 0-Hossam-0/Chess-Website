import { registerAs } from '@nestjs/config';
import ms, { StringValue } from 'ms';

export default registerAs('accessToken', () => ({
  cookieKey: process.env.ACCESS_TOKEN_KEY!,
  path: '/',
  signOptions: {
    secret: process.env.ACCESS_TOKEN_SECRET!,
    expiresIn: ms(process.env.ACCESS_TOKEN_EXPIRE_IN! as StringValue) / 1000,
  },
}));
