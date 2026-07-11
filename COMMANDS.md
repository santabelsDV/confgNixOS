# 🗂️ NixOS Flakes — Шпаргалка

## 🔄 Оновлення системи

```bash
# Оновити всі inputs (nixpkgs, home-manager тощо) у flake.lock
sudo nix flake update ~/config

# Застосувати конфігурацію
sudo nixos-rebuild switch --flake ~/config#nixos

# Оновити input і одразу застосувати
sudo nixos-rebuild switch --flake ~/config#nixos --update-input nixpkgs
```

---

## 📦 Встановити новий пакет

1. Відкрий потрібний файл (`apps/*.nix` або `configuration.nix`)
2. Додай пакет до `environment.systemPackages` або `home.packages`
3. Запусти:
```bash
sudo nixos-rebuild switch --flake ~/config#nixos
```

---

## 🧪 Тестування без застосування

```bash
# Тільки зібрати (не застосовувати)
sudo nixos-rebuild build --flake ~/config#nixos

# Тест (відкотиться після перезавантаження)
sudo nixos-rebuild test --flake ~/config#nixos
```

---

## ⚡ Разові пакети (без встановлення в систему)

```bash
# Запустити програму одноразово
nix run nixpkgs#назва-пакету

# Тимчасова оболонка з пакетом
nix shell nixpkgs#назва-пакету
```

---

## 🔍 Пошук пакетів

```bash
nix search nixpkgs назва
```
> Або онлайн: https://search.nixos.org

---

## 🧹 Очищення

```bash
# Видалити старі покоління (залишити останні N)
sudo nix-collect-garbage -d

# Або залишити покоління за останні 7 днів
sudo nix-collect-garbage --delete-older-than 7d

# Оптимізувати store
sudo nix store optimise
```

---

## 📜 Покоління (відкат системи)

```bash
# Список покоління
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Відкотитись на попереднє покоління
sudo nixos-rebuild switch --rollback

# Завантажитись у конкретне покоління (через меню GRUB)
# → вибрати "NixOS - Configuration X" при завантаженні
```

---

## 🔒 flake.lock

| Файл | Призначення |
|------|-------------|
| `flake.nix` | Оголошення inputs та конфігурації |
| `flake.lock` | Заморожені версії (commitHash) всіх inputs |

> `flake.lock` варто комітити в git — це гарантує відтворюваність.

---

## 📁 Структура конфігу

```
~/config/
├── flake.nix          # Головний файл flake
├── flake.lock         # Заморожені версії залежностей
├── configuration.nix  # Системна конфігурація
├── home.nix           # Home Manager
├── apps/              # Модулі для окремих програм
│   ├── steam.nix
│   └── ...
└── COMMANDS.md        # ← цей файл
```
