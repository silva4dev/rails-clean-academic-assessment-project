import { UnexpectedError } from "../../domain/exceptions";
import { HttpClient, HttpStatusCode, Right } from "../../shared_kernel";
import { GetStudentGradesResponse, GetStudentGradesService } from "../../domain/services/get-student-grades-service";

export class HttpGetStudentGradesService implements GetStudentGradesService {
  private readonly url: string;
  private readonly httpGetClient: HttpClient<GetStudentGradesResponse>;

  constructor(
    url: string,
    httpGetClient: HttpClient<GetStudentGradesResponse>
  ) {
    this.url = url;
    this.httpGetClient = httpGetClient
  }

  async execute(): Promise<any> {
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