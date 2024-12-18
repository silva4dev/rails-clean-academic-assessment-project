import { UnexpectedError } from "../../domain/exceptions";
import { HttpClient, HttpStatusCode, Right } from "../../shared_kernel";

export class HttpGetStudentGradesService {
  private readonly url: string;
  private readonly httpGetClient: HttpClient<any>;

  constructor(
    url: string,
    httpGetClient: HttpClient<any>
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