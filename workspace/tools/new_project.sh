#!/usr/bin/env bash

set -e

# projectディレクトリに移動
cd "$(dirname "$(cd "$(dirname "$0")" && pwd)")"

# プロジェクト名（引数が指定されていなければ my_project）
PROJECT_NAME="${1:-my_project}"

echo "🚀 Creating Clean Architecture Python Project: ${PROJECT_NAME}..."

# 1. ディレクトリ構造の作成
mkdir -p "${PROJECT_NAME}/src/${PROJECT_NAME}/domain/entities"
mkdir -p "${PROJECT_NAME}/src/${PROJECT_NAME}/domain/value_objects"
mkdir -p "${PROJECT_NAME}/src/${PROJECT_NAME}/domain/services"
mkdir -p "${PROJECT_NAME}/src/${PROJECT_NAME}/domain/repositories"
mkdir -p "${PROJECT_NAME}/src/${PROJECT_NAME}/domain/exceptions"

mkdir -p "${PROJECT_NAME}/src/${PROJECT_NAME}/usecases"

mkdir -p "${PROJECT_NAME}/src/${PROJECT_NAME}/adapters/controllers"
mkdir -p "${PROJECT_NAME}/src/${PROJECT_NAME}/adapters/repositories"
mkdir -p "${PROJECT_NAME}/src/${PROJECT_NAME}/adapters/presenters"

mkdir -p "${PROJECT_NAME}/src/${PROJECT_NAME}/infrastructure/db"
mkdir -p "${PROJECT_NAME}/src/${PROJECT_NAME}/infrastructure/web"

mkdir -p "${PROJECT_NAME}/tests/unit/domain"
mkdir -p "${PROJECT_NAME}/tests/unit/usecases"
mkdir -p "${PROJECT_NAME}/tests/integration"

# 2. __init__.py の配置 
# ※ src/ 直下および tests/ 配下には作成せず、src/パッケージ名/ 配下のみ作成します
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/__init__.py"
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/domain/__init__.py"
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/domain/entities/__init__.py"
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/domain/value_objects/__init__.py"
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/domain/services/__init__.py"
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/domain/repositories/__init__.py"
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/domain/exceptions/__init__.py"

touch "${PROJECT_NAME}/src/${PROJECT_NAME}/usecases/__init__.py"

touch "${PROJECT_NAME}/src/${PROJECT_NAME}/adapters/__init__.py"
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/adapters/controllers/__init__.py"
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/adapters/repositories/__init__.py"
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/adapters/presenters/__init__.py"

touch "${PROJECT_NAME}/src/${PROJECT_NAME}/infrastructure/__init__.py"
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/infrastructure/db/__init__.py"
touch "${PROJECT_NAME}/src/${PROJECT_NAME}/infrastructure/web/__init__.py"

# 3. エントリポイント (main.py)
cat <<'EOF' > "${PROJECT_NAME}/src/${PROJECT_NAME}/main.py"
def main() -> None:
    print("Hello from Clean Architecture Project!")

if __name__ == "__main__":
    main()
EOF

# 4. pyproject.toml の生成
cat <<EOF > "${PROJECT_NAME}/pyproject.toml"
[build-system]
requires = ["setuptools>=61.0"]
build-backend = "setuptools.build_meta"

[project]
name = "${PROJECT_NAME}"
version = "0.1.0"
description = "A Python project following Clean Architecture with src layout"
readme = "README.md"
requires-python = ">=3.14.7"
dependencies = []

[project.optional-dependencies]
dev = [
    "pip-tools>=7.6.0",
    "pytest>=9.1.1",
]

[project.scripts]
${PROJECT_NAME} = "${PROJECT_NAME}.main:main"

[tool.setuptools.packages.find]
where = ["src"]

[tool.pytest.ini_options]
testpaths = ["tests"]
pythonpath = ["src"]
EOF

# 5. .gitignore の生成
cat <<'EOF' > "${PROJECT_NAME}/.gitignore"
__pycache__/
*.py[cod]
*$py.class
.venv/
env/
venv/
.pytest_cache/
.mypy_cache/
.ruff_cache/
*.egg-info/
dist/
build/
.env
EOF

# 6. README.md の生成
cat <<EOF > "${PROJECT_NAME}/README.md"
# ${PROJECT_NAME}

Clean Architecture & src-layout を採用した Python プロジェクトです。

## ディレクトリ構造

\`\`\`text
src/${PROJECT_NAME}/
├── domain/                  # ドメイン層（純粋なビジネスロジック）
│   ├── entities/            # エンティティ
│   ├── value_objects/       # 値オブジェクト
│   ├── services/            # ドメインサービス
│   ├── repositories/        # リポジトリインターフェース (ABC / Protocol)
│   └── exceptions/          # ドメイン例外
├── usecases/                # ユースケース層
├── adapters/                # アダプター層
│   ├── controllers/
│   ├── presenters/
│   └── repositories/        # リポジトリ実装
└── infrastructure/          # インフラ層
    ├── db/
    └── web/
tests/                       # テストコード (__init__.py は配置しない)
├── unit/
└── integration/
\`\`\`
EOF

echo "✨ Clean Architecture Project successfully created in './${PROJECT_NAME}'!"