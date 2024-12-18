export class UnexpectedError extends Error {
  constructor () {
    super("Something wrong happened. Please try again soon.");
    this.name = "UnexpectedError"
  }
}