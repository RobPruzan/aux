CREATE TABLE `user` (
	`userID` text PRIMARY KEY NOT NULL,
	`username` text NOT NULL,
	`password` text NOT NULL
);
--> statement-breakpoint
CREATE INDEX `passwordIdx` ON `user` (`password`);