import { UnexpectedError } from "../../domain/exceptions";
import { GetStudentMaxGradeResponse, GetStudentMaxGradeService } from "../../domain/services/get-student-max-grade-service";
import { HttpClient, HttpStatusCode, Right } from "../../shared_kernel";

export class HttpGetStudentMaxGradeService implements GetStudentMaxGradeService {
  private readonly url: string;
  private readonly httpGetClient: HttpClient<GetStudentMaxGradeResponse>;

  constructor(
    url: string,
    httpGetClient: HttpClient<GetStudentMaxGradeResponse>
  ) {
    this.url = url;
    this.httpGetClient = httpGetClient
  }

  async execute(): Promise<GetStudentMaxGradeResponse> {
    const httpResponse = await this.httpGetClient.request({
      url: this.url,
      method: "get",
    });

    switch(httpResponse.statusCode) {
      case HttpStatusCode.ok: return Right<any>(httpResponse.body!);
      case HttpStatusCode.notFound: return Right<any>(httpResponse.body!);
      default: throw new UnexpectedError();
    }
  }
}