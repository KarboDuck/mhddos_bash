## Опис

### runner.sh - скрипт на bash, що керує [mhddos_proxy](https://github.com/porthole-ascend-cinnamon/mhddos_proxy)

* Запускається через one-liner в Linux, Mac OS, WSL (Windows Subsystem for Linux). Подальше втручання від користувача не обов'язкове.

`curl -s https://raw.githubusercontent.com/KarboDuck/karbo-wiki/master/runner.sh | bash`

* Автоматично встановлює все необхідне (git, python3, pip, mhddos_proxy, MHDDoS і всі залежності).

* Кожні 30 хвилин перевіряє оновлення mhddos_proxy і MHDDoS.

* Кожні 30 хвилин перевіряє оновлення [списку цілей](https://github.com/KarboDuck/karbo-wiki/blob/master/runner_targets).

Теоретично все це дозволяє залишити запущену копію runner.sh і вона самостійно буде оновлювати все ПЗ та список з актуальними цілями.

## Список цілей

runner.sh підтримує единий центральний [список цілей](https://github.com/KarboDuck/karbo-wiki/blob/master/runner_targets), який можна тримати в тому числі і на github.

`https://github.com/KarboDuck/karbo-wiki/blob/master/runner_targets`

Скрипт дозволяює обирати кілька рандомних цілей з цього списку. Кількість налаштовується. Це відрізняється від вбудованої в mhddos_proxy можливості "multiple targets".
Multiple targets вміє атакувати кілька різних IP, але метод атак повинен бути тим самим.

Параметр num_of_copies в runner.sh дозволяює запускати кілька копій mhddos_proxy і таким чином атакувати кілька цілей, або кілька наборів цілей різними методами.
