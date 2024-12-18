import { makeApiUrl, makeAxiosHttpClient } from "../../../shared_kernel";
import { makeHttpGetTopStudentsService } from "../../factories/http-get-top-students-service-factory";
import { HttpGetTopStudentsService } from "../../services/http-get-top-students-service";

jest.mock("axios");

jest.mock("../../../shared_kernel", () => ({
  makeApiUrl: jest.fn(),
  makeAxiosHttpClient: jest.fn(),
}));

describe("makeHttpGetTopStudentsService", () => {
  const mockApiUrl = "http://example.com/api/v1/students";
  const mockHttpClient = { request: jest.fn() };

  beforeEach(() => {
    (makeApiUrl as jest.Mock).mockReturnValue(mockApiUrl);
    (makeAxiosHttpClient as jest.Mock).mockReturnValue(mockHttpClient);
  });

  it("should return an instance of HttpGetTopStudentsService", () => {
    const service = makeHttpGetTopStudentsService();
    expect(service).toBeInstanceOf(HttpGetTopStudentsService);
  });

  it("should call makeApiUrl with the correct argument", () => {
    makeHttpGetTopStudentsService();
    expect(makeApiUrl).toHaveBeenCalledWith("/api/v1/students");
  });

  it("should call makeAxiosHttpClient", () => {
    makeHttpGetTopStudentsService();
    expect(makeAxiosHttpClient).toHaveBeenCalled();
  });

  it("should pass the correct arguments to HttpGetTopStudentsService constructor", () => {
    const service = makeHttpGetTopStudentsService();

    expect(service).toBeInstanceOf(HttpGetTopStudentsService);
    expect((service as any).url).toBe(mockApiUrl);
    expect((service as any).httpGetClient).toBe(mockHttpClient);
  });
});
