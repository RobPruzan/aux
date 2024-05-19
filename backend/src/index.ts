import { Elysia } from "elysia";

const app = new Elysia()
  .get("/", () => "Pong")
  .get("/queue", () => {})
  .post("/queue", () => {});
console.log(
  `🦊 Elysia is running at ${app.server?.hostname}:${app.server?.port}`
);
