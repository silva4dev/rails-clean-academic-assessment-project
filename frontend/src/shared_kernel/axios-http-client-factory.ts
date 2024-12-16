import { AxiosHttpClient } from "../infrastructure";

export const makeAxiosHttpClient = (): AxiosHttpClient => new AxiosHttpClient();