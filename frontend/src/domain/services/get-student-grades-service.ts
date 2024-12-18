import { Either, Service } from "../../shared_kernel";

export type GetStudentGradesResponse = Either<null, {
  data: Array<{
    id: string,
    name: string,
    created_at: Date,
    updated_at: Date,
    grades: Array<{
      id: string,
      value: number,
      created_at: Date,
      updated_at: Date,
      discipline: {
        id: string,
        name: string,
        days_interval: number,
        created_at: Date,
        updated_at: Date
      }
    }>,
    final_grade: number
  }>
}>;

export interface GetStudentGradesService
  extends Service<null, GetStudentGradesResponse> {}