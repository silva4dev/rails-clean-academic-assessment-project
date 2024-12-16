import { BaseEntity } from "./";

export type DisciplineEntity = BaseEntity & {
  name: string;
  days_interval: number;
}