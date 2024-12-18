import { UnexpectedError } from "../../domain/exceptions";
import { GetHistoriesResponse, GetHistoriesService } from "../../domain/services";
import { HttpClient, HttpStatusCode, Right } from "../../shared_kernel";

export class HttpGetHistoriesService implements GetHistoriesService {
  private readonly url: string;
  private readonly httpGetClient: HttpClient<GetHistoriesResponse>;

  constructor(
    url: string,
    httpGetClient: HttpClient<GetHistoriesResponse>
  ) {
    this.url = url;
    this.httpGetClient = httpGetClient
  }

  async execute(): Promise<GetHistoriesResponse> {
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