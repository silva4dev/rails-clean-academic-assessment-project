import { BaseEntity, DisciplineEntity, StudentEntity } from "./";

export type GradeEntity = BaseEntity & {
  value: number;
  student: StudentEntity;
  discipline: DisciplineEntity;
}