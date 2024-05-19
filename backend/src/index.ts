import { Elysia, t } from "elysia";
import { jwt } from "@elysiajs/jwt";
import * as TB from "./schema";
import { db } from "./db";
import { eq, getTableColumns } from "drizzle-orm";

const { password, ...cleanedUserTable } = getTableColumns(TB.user);

const app = new Elysia()
  .use(
    jwt({
      name: "jwt",
      secret: Bun.env.JWT_SECRET!,
    })
  )
  .get("/", () => "Pong")
  .post(
    "/register",
    async ({ jwt, body, set }) => {
      const hashedPassword = await Bun.password.hash(body.password);
      const newUser = await db
        .insert(TB.user)
        .values({ username: body.username, password: hashedPassword })
        .returning()
        .then((o) => o[0]);
      const jwtToken = await jwt.sign({
        userId: newUser.userId,
      });

      set.status = 200;

      return {
        jwtToken,
      };
    },
    {
      body: t.Object({
        username: t.String(),
        password: t.String(),
      }),
    }
  )
  .post(
    "/login",
    async ({ body, set }) => {
      const hashedPassword = await Bun.password.hash(body.password);
      const existingUser = (
        await db
          .select()
          .from(TB.user)
          .where(eq(TB.user.password, hashedPassword))
      ).at(0);

      if (!existingUser) {
        set.status = 400;
        return;
      }

      const { password, ...cleanedExistingUser } = existingUser;
      return cleanedExistingUser;
    },
    {
      body: t.Object({
        username: t.String(),
        password: t.String(),
      }),
    }
  )
  .get(
    "is-logged-in/:token",
    async ({ params, jwt, set }) => {
      const dataOrFailed = await jwt.verify(params.token);

      if (dataOrFailed === false) {
        set.status = 401;
        return;
      }

      const { username, id } = dataOrFailed;

      return { username, id };
    },
    { params: t.Object({ token: t.String() }) }
  )
  .get("/queue", () => {})
  .post("/queue", () => {});
console.log(
  `🦊 Elysia is running at ${app.server?.hostname}:${app.server?.port}`
);
