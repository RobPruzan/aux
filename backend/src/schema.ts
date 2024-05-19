import { index, sqliteTable, text } from "drizzle-orm/sqlite-core";
import { ulid } from "ulid";

const idCol = (colName: string) =>
  text(colName).primaryKey().notNull().$defaultFn(ulid);

export const user = sqliteTable(
  "user",
  {
    userId: idCol("userID"),
    username: text("username").notNull(),
    password: text("password").notNull(),
  },
  (tb) => ({
    passwordIndex: index("passwordIdx").on(tb.password),
  })
);
