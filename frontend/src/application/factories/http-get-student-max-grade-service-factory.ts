import { GetStudentMaxGradeService } from "../../domain/services/get-student-max-grade-service"
import { makeApiUrl, makeAxiosHttpClient } from "../../shared_kernel"
import { HttpGetStudentGradesService } from "../services"

export const makeHttpGetStudentMaxGradeService = (): GetStudentMaxGradeService =>
  new HttpGetStudentGradesService(makeApiUrl("/api/v1/student"), makeAxiosHttpClient())
