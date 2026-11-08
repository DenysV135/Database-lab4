-- Відключення перевірок для безпечного видалення та створення
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Видалення старих таблиць (Очищення перед розгортанням)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user_review`;
DROP TABLE IF EXISTS `mydb`.`trivia`;
DROP TABLE IF EXISTS `mydb`.`movie`;
DROP TABLE IF EXISTS `mydb`.`episode`;
DROP TABLE IF EXISTS `mydb`.`season`;
DROP TABLE IF EXISTS `mydb`.`series`;
DROP TABLE IF EXISTS `mydb`.`content_actors`;
DROP TABLE IF EXISTS `mydb`.`actors`;
DROP TABLE IF EXISTS `mydb`.`genres`;
DROP TABLE IF EXISTS `mydb`.`Content_has_Genres`;
DROP TABLE IF EXISTS `mydb`.`content`;
DROP TABLE IF EXISTS `mydb`.`age_ratings`;
DROP TABLE IF EXISTS `mydb`.`user`;
DROP TABLE IF EXISTS `mydb`.`subscription`;

-- -----------------------------------------------------
-- Table `mydb`.`age_ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`age_ratings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `mydb`.`content`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` TEXT NOT NULL,
  `release_year` YEAR(4) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `age_ratings_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Content_Age_ratings1_idx` (`age_ratings_id` ASC) VISIBLE,
  INDEX `idx_content_title` (`title` ASC) VISIBLE,
  CONSTRAINT `fk_Content_Age_ratings1`
    FOREIGN KEY (`age_ratings_id`)
    REFERENCES `mydb`.`age_ratings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`genres` (Зв'язок 1:N за вимогою викладача)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`genres` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `content_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_genres_content1_idx` (`content_id` ASC) VISIBLE,
  CONSTRAINT `fk_genres_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `mydb`.`content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`actors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `birthday` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_actor_name` (`name` ASC) VISIBLE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`subscription` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(255) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `phone` VARCHAR(45) NOT NULL,
  `subscription_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_Subscription1_idx` (`subscription_id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_user_Subscription1`
    FOREIGN KEY (`subscription_id`)
    REFERENCES `mydb`.`subscription` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Content_Actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`content_actors` (
  `actors_id` INT NOT NULL,
  `content_id` INT NOT NULL,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`actors_id`, `content_id`),
  INDEX `fk_Actors_has_content_content1_idx` (`content_id` ASC) VISIBLE,
  INDEX `fk_Actors_has_content_actors1_idx` (`actors_id` ASC) VISIBLE,
  CONSTRAINT `fk_Actors_has_content_actors1`
    FOREIGN KEY (`actors_id`)
    REFERENCES `mydb`.`actors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actors_has_Content_Content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `mydb`.`content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`series`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`series` (
  `content_id` INT NOT NULL,
  PRIMARY KEY (`content_id`),
  INDEX `fk_series_Content1_idx` (`content_id` ASC) VISIBLE,
  CONSTRAINT `fk_series_Content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `mydb`.`content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`season`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`season` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `series_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_season_series1_idx` (`series_id` ASC) VISIBLE,
  CONSTRAINT `fk_season_series1`
    FOREIGN KEY (`series_id`)
    REFERENCES `mydb`.`series` (`content_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`episode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`episode` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  `duration_mins` INT NOT NULL,
  `season_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_episode_season1_idx` (`season_id` ASC) VISIBLE,
  CONSTRAINT `fk_episode_season1`
    FOREIGN KEY (`season_id`)
    REFERENCES `mydb`.`season` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`user_review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rating` INT(10) NOT NULL,
  `text` TEXT NULL,
  `user_id` INT NOT NULL,
  `content_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_review_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_review_Content1_idx` (`content_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_review_Content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `mydb`.`content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movie` (
  `duration_mins` INT NOT NULL,
  `content_id` INT NOT NULL,
  PRIMARY KEY (`content_id`),
  INDEX `fk_Movie_Content1_idx` (`content_id` ASC) VISIBLE,
  CONSTRAINT `fk_Movie_Content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `mydb`.`content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`trivia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`trivia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `fact` TEXT NULL,
  `content_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trivia_content1_idx` (`content_id` ASC) VISIBLE,
  CONSTRAINT `fk_trivia_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `mydb`.`content` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- 1. Актори (10 записів)
INSERT INTO `mydb`.`actors` (`id`, `name`, `birthday`) VALUES
(1, 'Кіану Рівз', '1964-09-02'),
(2, 'Крістіан Бейл', '1974-01-30'),
(3, 'Браян Кренстон', '1956-03-07'),
(4, 'Міллі Боббі Браун', '2004-02-19'),
(5, 'Педро Паскаль', '1975-04-02'),
(6, 'Леонардо Ді Капріо', '1974-11-11'),
(7, 'Меттью Макконахі', '1969-11-04'),
(8, 'Кілліан Мерфі', '1976-05-25'),
(9, 'Том Генкс', '1956-07-09'),
(10, 'Бред Пітт', '1963-12-18');

-- 2. Вікові рейтинги (10 записів)
INSERT INTO `mydb`.`age_ratings` (`id`, `name`, `description`) VALUES
(1, 'G', 'Для будь-якої аудиторії'),
(2, 'PG', 'Бажана присутність батьків'),
(3, 'PG-13', 'Дітям до 13 років перегляд не рекомендований'),
(4, 'R', 'Особам до 17 років обов\'язковий супровід дорослих'),
(5, 'NC-17', 'Тільки для дорослих (18+)'),
(6, 'TV-Y', 'Для всіх дітей (Телебачення)'),
(7, 'TV-Y7', 'Для дітей від 7 років (Телебачення)'),
(8, 'TV-G', 'Для загальної аудиторії (Телебачення)'),
(9, 'TV-PG', 'Батьківський контроль (Телебачення)'),
(10, 'TV-14', 'Для осіб від 14 років (Телебачення)');

-- 3. Контент (20 записів загалом: 10 фільмів і 10 серіалів)
INSERT INTO `mydb`.`content` (`id`, `description`, `release_year`, `title`, `age_ratings_id`) VALUES
(1, 'Культовий фантастичний бойовик про віртуальну реальність.', 1999, 'Матриця', 4),
(2, 'Бетмен протистоїть анархісту Джокеру в Ґотемі.', 2008, 'Темний лицар', 3),
(3, 'Злодій, який краде секрети через сни, отримує нове завдання.', 2010, 'Початок', 3),
(4, 'Вчитель хімії починає варити метамфетамін.', 2008, 'Пуститися берега', 5),
(5, 'Таємниче зникнення хлопчика та експерименти.', 2016, 'Дивні дива', 3),
(6, 'Фільм про геніального винахідника-супергероя.', 2008, 'Залізна людина', 3),
(7, 'Зворушлива історія маленького робота-сміттяра.', 2008, 'ВОЛЛ-І', 1),
(8, 'Ветеран війни захищає сусідів-іммігрантів.', 2008, 'Гран Торіно', 4),
(9, 'Історія кохання на тлі післявоєнної Німеччини.', 2008, 'Читець', 4),
(10, 'Хлопець із трущоб бере участь у телегрі.', 2008, 'Мільйонер із нетрів', 4),
(11, 'Історія чоловіка, який народжується старим.', 2008, 'Бенджамін Баттон', 3),
(12, 'Група дослідників подорожує крізь червоточину в космосі.', 2014, 'Інтерстеллар', 3),
(13, 'Історія контрабандиста та дівчинки у постапокаліптичному світі.', 2023, 'Останні з нас', 10),
(14, 'Міні-серіал про аварію на Чорнобильській АЕС.', 2019, 'Чорнобиль', 10),
(15, 'Детективи розслідують складні та заплутані злочини.', 2014, 'Справжній детектив', 10),
(16, 'Комедійний серіал про будні працівників паперової компанії.', 2005, 'Офіс', 9),
(17, 'Життя шістьох друзів у Нью-Йорку.', 1994, 'Друзі', 9),
(18, 'Приквел до серіалу Пуститися берега про адвоката.', 2015, 'Краще подзвоніть Солу', 10),
(19, 'Сучасна адаптація історій про Шерлока Холмса.', 2010, 'Шерлок', 10),
(20, 'Геніальний, але цинічний лікар розв\'язує медичні загадки.', 2004, 'Доктор Хаус', 10);

-- 4. Жанри (10 записів)
INSERT INTO `mydb`.`genres` (`id`, `name`, `description`, `content_id`) VALUES
(1, 'Sci-Fi', 'Наукова фантастика', 1),
(2, 'Drama', 'Драматичні історії', 4),
(3, 'Action', 'Бойовики та динамічні сцени', 2),
(4, 'Thriller', 'Гостросюжетні фільми', 3),
(5, 'Horror', 'Фільми жахів та містика', 5),
(6, 'Comedy', 'Комедії', 16),
(7, 'Animation', 'Анімаційні фільми', 7),
(8, 'History', 'Історичні події', 14),
(9, 'Detective', 'Детективи та розслідування', 15),
(10, 'Adventure', 'Пригоди', 12);

-- 5. Підписки (10 записів)
INSERT INTO `mydb`.`subscription` (`id`, `name`, `description`) VALUES
(1, 'Basic', '720p, 1 пристрій'),
(2, 'Standard', '1080p, 2 пристрої'),
(3, 'Premium', '4K HDR, 4 пристрої'),
(4, 'Mobile', 'Тільки смартфони та планшети'),
(5, 'Family', 'Преміум з батьківським контролем'),
(6, 'Student', 'Знижка для студентів, 1080p'),
(7, 'Annual Basic', 'Базова підписка на рік зі знижкою'),
(8, 'Annual Premium', 'Преміум на рік зі знижкою'),
(9, 'Trial', 'Безкоштовний тестовий період на 14 днів'),
(10, 'Ultra', '8K якість, до 6 пристроїв одночасно');

-- 6. Користувачі (10 записів)
INSERT INTO `mydb`.`user` (`id`, `username`, `email`, `password`, `create_time`, `phone`, `subscription_id`) VALUES
(1, 'olexiy_k', 'olexiy@example.com', '$2y$10$e8w.hashpassword1', CURRENT_TIMESTAMP, '+380501112233', 3),
(2, 'maryna_t', 'maryna@example.com', '$2y$10$e8w.hashpassword2', CURRENT_TIMESTAMP, '+380672223344', 2),
(3, 'dmytro_v', 'dmytro@example.com', '$2y$10$e8w.hashpassword3', CURRENT_TIMESTAMP, '+380933334455', 1),
(4, 'olena_b', 'olena@example.com', '$2y$10$e8w.hashpassword4', CURRENT_TIMESTAMP, '+380504445566', 3),
(5, 'yuriy_s', 'yuriy@example.com', '$2y$10$e8w.hashpassword5', CURRENT_TIMESTAMP, '+380685556677', 4),
(6, 'andriy_m', 'andriy@example.com', '$2y$10$e8w.hashpassword6', CURRENT_TIMESTAMP, '+380731112233', 6),
(7, 'iryna_p', 'iryna@example.com', '$2y$10$e8w.hashpassword7', CURRENT_TIMESTAMP, '+380992223344', 7),
(8, 'maksym_r', 'maksym@example.com', '$2y$10$e8w.hashpassword8', CURRENT_TIMESTAMP, '+380663334455', 5),
(9, 'viktoria_z', 'viktoria@example.com', '$2y$10$e8w.hashpassword9', CURRENT_TIMESTAMP, '+380504449988', 8),
(10, 'taras_l', 'taras@example.com', '$2y$10$e8w.hashpassword0', CURRENT_TIMESTAMP, '+380675551122', 10);

-- 7. Актори в контенті (10 записів)
INSERT INTO `mydb`.`content_actors` (`actors_id`, `content_id`, `role_name`) VALUES
(1, 1, 'Нео / Томас Андерсон'),
(2, 2, 'Брюс Вейн / Бетмен'),
(3, 4, 'Волтер Вайт'),
(4, 5, 'Одинадцять (Eleven)'),
(5, 13, 'Джоел Міллер'),
(6, 3, 'Домінік Кобб'),
(7, 12, 'Джозеф Купер'),
(8, 2, 'Джонатан Крейн / Опудало'),
(9, 7, 'Озвучка (Камео)'),
(10, 3, 'Камео на фоні');

-- 8. Фільми (10 записів, content_id від 1 до 3 та від 6 до 12)
INSERT INTO `mydb`.`movie` (`duration_mins`, `content_id`) VALUES
(136, 1),
(152, 2),
(148, 3),
(126, 6),
(98, 7),
(116, 8),
(124, 9),
(120, 10),
(166, 11),
(169, 12);

-- 9. Серіали (10 записів, content_id 4, 5 та від 13 до 20)
INSERT INTO `mydb`.`series` (`content_id`) VALUES
(4), (5), (13), (14), (15), (16), (17), (18), (19), (20);

-- 10. Сезони (10 записів, прив'язані до серіалів вище)
INSERT INTO `mydb`.`season` (`id`, `number`, `name`, `series_id`) VALUES
(1, 1, 'Сезон 1: Початок справи', 4),
(2, 2, 'Сезон 2: Розширення', 4),
(3, 1, 'Сезон 1: Зникнення Вілла', 5),
(4, 2, 'Сезон 2: Тіньовий монстр', 5),
(5, 1, 'Сезон 1: Спалах', 13),
(6, 1, 'Сезон 1: Катастрофа', 14),
(7, 1, 'Сезон 1: Темрява', 15),
(8, 1, 'Сезон 1: Знайомство', 16),
(9, 1, 'Сезон 1: Кав\'ярня', 17),
(10, 1, 'Сезон 1: Етюд у рожевих тонах', 19);

-- 11. Епізоди (10 записів, прив'язані до сезонів вище)
INSERT INTO `mydb`.`episode` (`id`, `name`, `number`, `duration_mins`, `season_id`) VALUES
(1, 'Пілот', 1, 58, 1),
(2, 'Кіт у мішку', 2, 48, 1),
(3, 'Глава 1: Зникнення Вілла Баєрса', 1, 48, 3),
(4, 'Глава 2: Дивачка на Кленовому бульварі', 2, 55, 3),
(5, 'Коли ти загубився в темряві', 1, 81, 5),
(6, '1:23:45', 1, 59, 6),
(7, 'Довга яскрава темрява', 1, 60, 7),
(8, 'Пілотний випуск', 1, 22, 8),
(9, 'Епізод, де Моніка бере нову сусідку', 1, 22, 9),
(10, 'Етюд у рожевих тонах', 1, 88, 10);

-- 12. Цікаві факти - Trivia (10 записів)
INSERT INTO `mydb`.`trivia` (`id`, `title`, `fact`, `content_id`) VALUES
(1, 'Зелений код', 'Зелений код у заставці насправді є рецептами суші.', 1),
(2, 'Гонорар', 'Кіану Рівз віддав частину гонорару команді.', 1),
(3, 'Джокер', 'Гіт Леджер самостійно закрився в готелі для підготовки.', 2),
(4, 'Виживання Джессі', 'Персонаж Джессі Пінкмана мав померти в 1 сезоні.', 4),
(5, 'Монстр', 'Для створення монстра використовували реальні макети.', 5),
(6, 'Кукурудза', 'Для фільму Крістофер Нолан посадив справжнє поле кукурудзи.', 12),
(7, 'Радіація', 'Звуки дозиметра були записані на справжній ЧАЕС.', 14),
(8, 'Зйомки', 'Офіс знімали у справжній будівлі, а не в студії.', 16),
(9, 'Заставка', 'Фонтан із заставки знаходиться на студії Warner Bros.', 17),
(10, 'Медицина', 'Сценаристи консультувалися зі справжніми лікарями.', 20);

-- 13. Відгуки користувачів (10 записів)
INSERT INTO `mydb`.`user_review` (`id`, `rating`, `text`, `user_id`, `content_id`) VALUES
(1, 10, 'Шедевр кінематографа, який змінив жанр.', 1, 1),
(2, 9, 'Неперевершена гра Джокера.', 2, 2),
(3, 10, 'Найкраща драма з коли-небудь створених.', 3, 4),
(4, 8, 'Чудова ностальгічна атмосфера 80-х.', 4, 5),
(5, 9, 'Дуже заплутаний, але геніальний сюжет.', 5, 3),
(6, 10, 'Візуал космосу вражає до глибини душі!', 6, 12),
(7, 9, 'Дуже реалістично передано атмосферу катастрофи.', 7, 14),
(8, 10, 'Найкращий комедійний серіал для відпочинку.', 8, 16),
(9, 8, 'Класика ситкомів, можна передивлятися вічно.', 9, 17),
(10, 10, 'Геніальний лікар і цікаві медичні загадки.', 10, 20);

-- Відновлення налаштувань перевірок
SET SQL_MODE=@OLD_SQL_MODE;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
