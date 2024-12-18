import { Either, Service } from "../../shared_kernel";

export type GetStudentMaxGradeResponse = Either<null, {
  data: {
    id: string,
    name: string,
    final_grade: number
  }
}>;

export interface GetStudentMaxGradeService
  extends Service<null, GetStudentMaxGradeResponse> {}