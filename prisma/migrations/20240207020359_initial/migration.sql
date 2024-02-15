-- CreateTable
CREATE TABLE `User` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `username` VARCHAR(191) NULL,
    `elevenlabsCharacterQuotaUsed` INTEGER NOT NULL DEFAULT 0,
    `elevenlabsCharacterQuota` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `User_username_key`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SeedSound` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `bucketKey` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `uploadComplete` BOOLEAN NOT NULL DEFAULT false,
    `fileSize` BIGINT UNSIGNED NULL,
    `uploaderId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `SeedSound_bucketKey_key`(`bucketKey`),
    INDEX `SeedSound_bucketKey_idx`(`bucketKey`),
    INDEX `SeedSound_uploaderId_idx`(`uploaderId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PreviewSound` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `bucketKey` VARCHAR(191) NOT NULL,
    `voiceModelId` VARCHAR(191) NOT NULL,
    `iconEmoji` VARCHAR(191) NOT NULL,
    `uploadComplete` BOOLEAN NOT NULL DEFAULT false,
    `fileSize` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `PreviewSound_bucketKey_key`(`bucketKey`),
    INDEX `PreviewSound_voiceModelId_idx`(`voiceModelId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TestSound` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `bucketKey` VARCHAR(191) NOT NULL,
    `voiceModelId` VARCHAR(191) NOT NULL,
    `uploadComplete` BOOLEAN NOT NULL DEFAULT false,
    `fileSize` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `TestSound_bucketKey_key`(`bucketKey`),
    INDEX `TestSound_voiceModelId_idx`(`voiceModelId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `VoiceModel` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `voiceId` VARCHAR(191) NOT NULL,
    `forkParentId` VARCHAR(191) NULL,
    `version` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `elevenLabsModelId` VARCHAR(191) NOT NULL DEFAULT 'eleven_english_v2',
    `elevenLabsStability` DOUBLE NOT NULL DEFAULT 0.35,
    `elevenLabsSimilarityBoost` DOUBLE NOT NULL DEFAULT 0.98,
    `elevenLabsStyle` DOUBLE NOT NULL DEFAULT 0.0,
    `elevenLabsSpeakerBoost` BOOLEAN NOT NULL DEFAULT true,
    `published` BOOLEAN NOT NULL DEFAULT false,

    INDEX `VoiceModel_forkParentId_idx`(`forkParentId`),
    INDEX `VoiceModel_voiceId_idx`(`voiceId`),
    UNIQUE INDEX `VoiceModel_voiceId_version_key`(`voiceId`, `version`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `VoiceModelSupportedLanguages` (
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `languageId` VARCHAR(191) NOT NULL,
    `voiceModelId` VARCHAR(191) NOT NULL,

    INDEX `VoiceModelSupportedLanguages_voiceModelId_idx`(`voiceModelId`),
    INDEX `VoiceModelSupportedLanguages_languageId_idx`(`languageId`),
    PRIMARY KEY (`languageId`, `voiceModelId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Language` (
    `id` VARCHAR(191) NOT NULL,
    `iso639_1` VARCHAR(191) NOT NULL,
    `displayName` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Voice` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `ownerUserId` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL DEFAULT 'Untitled Voice',
    `score` INTEGER NOT NULL DEFAULT 0,
    `warcraftNpcDisplayId` VARCHAR(191) NULL,
    `uniqueWarcraftNpcId` VARCHAR(191) NULL,
    `forkParentId` VARCHAR(191) NULL,

    INDEX `Voice_ownerUserId_idx`(`ownerUserId`),
    INDEX `Voice_warcraftNpcDisplayId_idx`(`warcraftNpcDisplayId`),
    INDEX `Voice_uniqueWarcraftNpcId_idx`(`uniqueWarcraftNpcId`),
    INDEX `Voice_forkParentId_idx`(`forkParentId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Favorite` (
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `voiceId` VARCHAR(191) NOT NULL,

    INDEX `Favorite_voiceId_idx`(`voiceId`),
    INDEX `Favorite_userId_idx`(`userId`),
    PRIMARY KEY (`userId`, `voiceId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Vote` (
    `type` ENUM('UPVOTE', 'DOWNVOTE') NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `voiceId` VARCHAR(191) NOT NULL,

    INDEX `Vote_voiceId_idx`(`voiceId`),
    INDEX `Vote_userId_idx`(`userId`),
    PRIMARY KEY (`userId`, `voiceId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `VoiceModelSeedSounds` (
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `voiceModelId` VARCHAR(191) NOT NULL,
    `seedSoundId` VARCHAR(191) NOT NULL,
    `active` BOOLEAN NOT NULL DEFAULT true,

    INDEX `VoiceModelSeedSounds_seedSoundId_idx`(`seedSoundId`),
    INDEX `VoiceModelSeedSounds_voiceModelId_idx`(`voiceModelId`),
    INDEX `VoiceModelSeedSounds_active_idx`(`active`),
    PRIMARY KEY (`voiceModelId`, `seedSoundId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `WacraftNpcDisplay` (
    `id` VARCHAR(191) NOT NULL,
    `modelFilePath` VARCHAR(191) NOT NULL,
    `raceId` INTEGER NOT NULL,
    `genderId` INTEGER NOT NULL,
    `voiceName` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `WacraftNpcDisplay_modelFilePath_key`(`modelFilePath`),
    UNIQUE INDEX `WacraftNpcDisplay_voiceName_key`(`voiceName`),
    FULLTEXT INDEX `WacraftNpcDisplay_voiceName_idx`(`voiceName`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `WarcraftNpcDisplays` (
    `id` VARCHAR(191) NOT NULL,
    `npcId` INTEGER NOT NULL,
    `displayId` VARCHAR(191) NOT NULL,

    INDEX `WarcraftNpcDisplays_npcId_idx`(`npcId`),
    INDEX `WarcraftNpcDisplays_displayId_idx`(`displayId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `WarcraftNpc` (
    `npcId` INTEGER UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `uniqueWarcraftNpcId` VARCHAR(191) NOT NULL,

    INDEX `WarcraftNpc_uniqueWarcraftNpcId_idx`(`uniqueWarcraftNpcId`),
    PRIMARY KEY (`npcId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UniqueWarcraftNpc` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `UniqueWarcraftNpc_name_key`(`name`),
    FULLTEXT INDEX `UniqueWarcraftNpc_name_idx`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RawVoiceline` (
    `id` VARCHAR(191) NOT NULL,
    `source` VARCHAR(191) NOT NULL,
    `questName` TEXT NULL,
    `questId` INTEGER UNSIGNED NULL,
    `text` TEXT NOT NULL,
    `npcId` INTEGER NULL,
    `expansion` INTEGER NOT NULL,

    INDEX `RawVoiceline_npcId_idx`(`npcId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
