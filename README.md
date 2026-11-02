# 🚀 agy-top — Real-Time TUI Monitor for Antigravity (`agy`)

Інтерактивна консольна утиліта (у стилі `htop` / `btop`) на базі Python та `Textual` для моніторингу процесів, квот моделей (`gemini-5h`, `gemini-weekly`, `claude`, `argon`) та витрати токенів **Antigravity CLI (`agy`)** у режимі реального часу.

---

## ✨ Можливості

1. **Models & Quota (Офіційні квоти в реальному часі — 0 токенів):**
   * Зчитує залишок квот напряму через `agy -p "/usage" --output-format json` (або локальний кеш API), не витрачаючи жодного токена.
   * Окремі кольорові картки та прогрес-бари для:
     * **Gemini Models** (`5-Hour` та `Weekly`)
     * **Claude & GPT Models** (`5-Hour` та `Weekly`)
     * **Gemini 4 Argon** (`5-Hour` та `Weekly`)
   * Точний таймер зворотного відліку до скидання кожного вікна (`reset in Xh Ym`).
2. **Active `agy` Processes (Живий моніторинг процесів):**
   * Автоматично знаходить усі запущені процеси `agy` у системі через `/proc` та `ps`.
   * Показує `PID`, `PPID`, `Model`, `CPU%`, `MEM`, `Runtime`, `Status` та текст поточного завдання (`Prompt / Task`).
   * Нижня панель **Process Inspector** показує повну команду, батьківський процес та аргументи обраного агента при навігації стрілками `↑` / `↓`.
3. **Today's Token Usage & Recent Turns:**
   * Підраховує використані за добу вхідні (`Input`), вихідні (`Output`) та кешовані (`Cache Read` + `% hit ratio`) токени з локальних транскриптів `~/.gemini/antigravity-cli/brain/`.
   * Окрема вкладка **Session Logs (`[3]`)** з історією останніх 50 кроків усіх сесій.

---

## 🛠️ Встановлення (Покрокова інструкція)

### Варіант 1: Швидке автоматичне встановлення (Рекомендовано)

Виконайте в терміналі:

```bash
git clone https://github.com/cyberdid/agy-top.git
cd agy-top
chmod +x install.sh
./install.sh
```

Скрипт `install.sh` сам перевірить Python 3, встановить бібліотеки `textual` і `rich`, скопіює `agy-top` у `~/.local/bin/agy-top` і додасть шлях у `PATH`.

---

### Варіант 2: Встановлення в один рядок (без клонування в поточну папку)

```bash
git clone https://github.com/cyberdid/agy-top.git /tmp/agy-top && bash /tmp/agy-top/install.sh && rm -rf /tmp/agy-top
```

---

### Варіант 3: Ручне встановлення

1. **Переконайтеся, що встановлено Python 3.8+ та `pip`:**
   ```bash
   sudo apt update && sudo apt install -y python3 python3-pip
   ```
2. **Встановіть залежності (`textual` та `rich`):**
   ```bash
   pip3 install --user textual rich
   # Якщо у вас Ubuntu 23.04+ / Debian 12+ (PEP 668):
   pip3 install --user --break-system-packages textual rich
   ```
3. **Завантажте скрипт у `~/.local/bin/agy-top` та зробіть його виконуваним:**
   ```bash
   mkdir -p ~/.local/bin
   curl -fsSL https://raw.githubusercontent.com/cyberdid/agy-top/main/agy-top -o ~/.local/bin/agy-top
   chmod +x ~/.local/bin/agy-top
   ```
4. **Додайте `~/.local/bin` до `PATH` (якщо ще не додано):**
   ```bash
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

---

## ▶️ Запуск та гарячі клавіші

Після встановлення запускайте з будь-якого терміналу:

```bash
agy-top
```

### Гарячі клавіші в програмі:

| Клавіша | Дія |
| :---: | :--- |
| **`1`** | Вкладка **Dashboard** (Квоти + Активні процеси + Інспектор + Токени) |
| **`2`** або **`m`** | Вкладка **All Models & Quotas** (Детальна таблиця всіх моделей та лімітів) |
| **`3`** | Вкладка **Session Logs** (Історія останніх 50 запитів із токенами) |
| **`↑` / `↓`** | Вибір активного процесу `agy` в таблиці для огляду повного промпту внизу |
| **`r`** | Примусове миттєве оновлення квот (`agy -p /usage`) |
| **`s`** | Перемикання сортування процесів (`CPU%` → `MEM` → `TIME` → `PID`) |
| **`p`** або **`Space`** | Пауза / відновлення оновлення екрана |
| **`q`** | Вихід із програми |

---

## 📋 Вимоги

* **ОС:** Linux (Ubuntu, Debian, Arch, Fedora тощо) або macOS
* **Python:** 3.8 або новіший (`textual`, `rich`)
* **Antigravity CLI:** встановлений та авторизований бінарник `agy` у `PATH`

---

## 📄 Ліцензія

MIT License — вільно використовуйте, модифікуйте та поширюйте.
