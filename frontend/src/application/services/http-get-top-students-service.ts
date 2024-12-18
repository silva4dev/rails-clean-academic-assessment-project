import { UnexpectedError } from "../../domain/exceptions";
import { GetTopStudentsResponse, GetTopStudentsService } from "../../domain/services";
import { HttpClient, HttpStatusCode, Right } from "../../shared_kernel";

export class HttpGetTopStudentsService implements GetTopStudentsService {
  private readonly url: string;
  private readonly httpGetClient: HttpClient<GetTopStudentsResponse>;

  constructor(
    url: string,
    httpGetClient: HttpClient<GetTopStudentsResponse>
  ) {
    this.url = url;
    this.httpGetClient = httpGetClient
  }

  async execute(): Promise<GetTopStudentsResponse> {
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