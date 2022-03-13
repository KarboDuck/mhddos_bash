## Опис

### runner.sh - скрипт на bash, що керує [mhddos_proxy](https://github.com/porthole-ascend-cinnamon/mhddos_proxy)

* Запускається через one-liner в Linux, Mac OS, WSL (Windows Subsystem for Linux). Подальше втручання від користувача не обов'язкове.

`curl -s https://raw.githubusercontent.com/KarboDuck/karbo-wiki/master/runner.sh | bash`

* Автоматично встановлює все необхідне (git, python3, pip, mhddos_proxy, MHDDoS і всі залежності).

* Кожні 30 хвилин перевіряє і завантажує оновлення mhddos_proxy і MHDDoS.

* Кожні 30 хвилин перевіряє і завантажує оновлення [списку цілей](https://github.com/KarboDuck/karbo-wiki/blob/master/runner_targets).

Теоретично все це дозволяє залишити запущену копію runner.sh і вона самостійно буде оновлювати все ПЗ та список з цілями.

## Список цілей

<img width="1484" alt="Screenshot 2022-03-13 at 18 09 49" src="https://user-images.githubusercontent.com/53382906/158068598-cd0627b6-aee6-4255-a17f-715ca1a86b2d.png">

runner.sh підтримує единий центральний [список цілей](https://github.com/KarboDuck/karbo-wiki/blob/master/runner_targets), який можна тримати в тому числі і на github.

`https://github.com/KarboDuck/karbo-wiki/blob/master/runner_targets`

Скрипт дозволяює обирати кілька рандомних цілей з цього списку. Кількість налаштовується. Це відрізняється від вбудованої в mhddos_proxy можливості "multiple targets".
Multiple targets вміє атакувати кілька різних IP, але метод атак повинен бути тим самим.

Параметр num_of_copies в runner.sh дозволяює запускати кілька копій mhddos_proxy і таким чином атакувати кілька цілей, або кілька наборів цілей різними методами.
