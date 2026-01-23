import { Response } from 'express';

export interface ICreateCookie {
  res: Response;
  cookieKey: string;
  cookieValue: string;
  path: string;
  maxAge: number;
}

export interface IClearCookie {
  res: Response;
  cookieKey: string;
}
