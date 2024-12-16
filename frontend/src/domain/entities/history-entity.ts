import { BaseEntity, StudentEntity } from "./";

export type HistoryEntity = BaseEntity & {
  reference_date: Date;
  final_grade: number;
  student: StudentEntity
}