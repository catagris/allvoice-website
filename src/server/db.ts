import { PrismaClient } from "@prisma/client";

import { env } from "~/env.mjs";

const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined;
};

export const prisma =
  globalForPrisma.prisma ??
  new PrismaClient({
    log:
      env.NODE_ENV === "development" ? ["query", "error", "warn"] : ["error"],
  });

if (env.NODE_ENV !== "production") globalForPrisma.prisma = prisma;

export async function decrementVoiceLikes(voiceId: string) {
  return await prisma.voice.update({
    where: {
      id: voiceId,
    },
    data: {
      likes: {
        decrement: 1,
      },
    },
  });
}

export async function incrementVoiceLikes(voiceId: string) {
  return await prisma.voice.update({
    where: {
      id: voiceId,
    },
    data: {
      likes: {
        increment: 1,
      },
    },
  });
}
