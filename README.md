## Опис

### runner.sh - скрипт на bash, що керує [mhddos_proxy](https://github.com/porthole-ascend-cinnamon/mhddos_proxy)

* Запускається через one-liner в Linux і WSL (Windows Subsystem for Linux). Подальше втручання від користувача не обов'язкове. 
 
```
curl -s https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner.sh | bash
```
* Автоматично встановлює git, python3, pip, mhddos_proxy, MHDDoS і всі залежності.
* 
* Праюцює із базою сайтів [Українського женця](https://github.com/Aruiem234/auto_mhddos/blob/main/runner_targets).

* База цілей оновлюється кожні 15 хвилин.

* Під час запуску перевіряється і завантажується оновлення mhddos_proxy і MHDDoS.

Теоретично все це дозволяє залишити runner.sh на ПК/vps і він самостійно буде оновлювати все ПЗ та список з цілями.

Рекомендовано використовувати на Ubuntu 20.04. На інших системах не перевірялось. Можливо буде працювати на всіх Ubuntu починаючи з 18.04, усіх похідних Ubuntu та WSL2.
