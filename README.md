## Опис

### runner.sh - скрипт на bash, що керує [mhddos_proxy](https://github.com/porthole-ascend-cinnamon/mhddos_proxy)

* Запускається через one-liner в Linux, Mac OS, WSL (Windows Subsystem for Linux). Подальше втручання від користувача не обов'язкове.

`curl -s https://raw.githubusercontent.com/KarboDuck/karbo-wiki/master/runner.sh | bash`

* Автоматично встановлює все необхідне (git, python3, pip, mhddos_proxy, MHDDoS і всі залежності).

* Кожні 30 хвилин перевіряє і завантажує оновлення mhddos_proxy і MHDDoS.

* Кожні 30 хвилин перевіряє і завантажує оновлений [список цілей](https://github.com/KarboDuck/karbo-wiki/blob/master/runner_targets).

Теоретично все це дозволяє залишити runner.sh на ПК чи vps і він самостійно буде оновлювати все ПЗ та список з цілями.

## Список цілей

<img width="1484" alt="Screenshot 2022-03-13 at 18 09 49" src="https://user-images.githubusercontent.com/53382906/158068598-cd0627b6-aee6-4255-a17f-715ca1a86b2d.png">

runner.sh підтримує единий центральний [список цілей](https://github.com/KarboDuck/karbo-wiki/blob/master/runner_targets), який можна тримати на github. Список можна редагувати "на льоту" і при наступному оновленні (по замовчуванню кожні 30 хв) всі користувачі runner.sh будуть працювати з новим списком цілей.

`https://github.com/KarboDuck/karbo-wiki/blob/master/runner_targets`

Скрипт дозволяює обирати одразу кілька рандомних цілей з списку. Кількість налаштовується. Це відрізняється від вбудованої в mhddos_proxy можливості "multiple targets".
Multiple targets вміє атакувати кілька різних IP, але метод атак повинен бути тим самим.

Параметр num_of_copies в runner.sh дозволяює запускати кілька копій mhddos_proxy і таким чином атакувати кілька цілей різними методами.

Через те що цілі обираються рандомно, не обовґязково розкидувати користувачів по групам і координувати їх між собою. Рандом розподілить навантаження автоматично.

Цілі не обовґязково видаляти із списку. Їх можна просто закоментувати і розкоментувати пізніше, якщо вони знов знадобляться. Скрипт шукає лише строки, які починаються на 'runner.py'.