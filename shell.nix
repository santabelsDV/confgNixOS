{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Додаємо необхідні пакети для збірки та запуску
  buildInputs = with pkgs; [
    python313
    python313Packages.pip
    stdenv.cc.cc.lib # Сама бібліотека libstdc++.so.6
  ];

  # Прокидаємо шлях до системних C++ бібліотек, щоб Python їх бачив
  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"

    # 1. Створюємо venv, якщо немає
    if [ ! -d ".venv" ]; then
      echo "🤖 Створюю віртуальне оточення Python..."
      python -m venv .venv
    fi

    # 2. Активуємо
    source .venv/bin/activate

    # 3. Насильно оновлюємо pip та встановлюємо стабільну версію litellm
    echo "📦 Перевіряю та доставляю залежності LiteLLM..."
    pip install --quiet --upgrade pip
    pip install --quiet "litellm[proxy]"

    # 4. Ваш API-ключ Gemini
    export GEMINI_API_KEY="AQ.Ab8RN6JgMkM62bsU0qhCfYSJYD4MPBTGs6pX-L0FVl-vK6IDRg"

    # 5. Запуск
    echo "🚀 Запускаю локальний проксі на http://localhost:4000 ..."
    litellm --model gemini/gemini-2.5-flash
  '';
}
