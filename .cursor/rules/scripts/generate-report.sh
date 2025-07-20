#!/bin/bash

# 📊 Cursor Rules System Report Generator
# Cursorルールシステムの統計・状況レポート生成

set -e

# プロジェクト設定読み込み
if [[ -f ".cursor-project-config" ]]; then
    source .cursor-project-config
else
    PROJECT_NAME="Unknown Project"
    TECH_STACK="Unknown"
    TEAM_SIZE="Unknown"
    PROJECT_TYPE="Unknown"
    REPO_URL="Unknown"
fi

# レポート生成開始
echo "# 📊 ${PROJECT_NAME} - Cursor Rules システム状況レポート"
echo ""
echo "**生成日時**: $(date '+%Y年%m月%d日 %H:%M:%S')"
echo "**生成者**: Cursor Rules Report Generator v1.0"
echo ""

# プロジェクト基本情報
echo "## 🎯 プロジェクト基本情報"
echo ""
echo "| 項目 | 値 |"
echo "|------|-----|"
echo "| プロジェクト名 | ${PROJECT_NAME} |"
echo "| プロジェクトタイプ | ${PROJECT_TYPE} |"
echo "| 技術スタック | ${TECH_STACK} |"
echo "| チーム規模 | ${TEAM_SIZE} |"
echo "| リポジトリ | ${REPO_URL} |"
if [[ -n "${DEVELOPMENT_PERIOD:-}" ]]; then
    echo "| 開発期間 | ${DEVELOPMENT_PERIOD} |"
fi
if [[ -n "${BRANCH_STRATEGY:-}" ]]; then
    echo "| ブランチ戦略 | ${BRANCH_STRATEGY} |"
fi
echo ""

# ファイル統計
echo "## 📋 ファイル統計"
echo ""

total_mdc=$(find .cursor/rules -name "*.mdc" 2>/dev/null | wc -l | tr -d ' ')
total_md=$(find .cursor/rules -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
total_files=$((total_mdc + total_md))

always_apply_true=$(grep -r "alwaysApply: true" .cursor/rules/ --include="*.mdc" 2>/dev/null | wc -l | tr -d ' ')
always_apply_false=$(grep -r "alwaysApply: false" .cursor/rules/ --include="*.mdc" 2>/dev/null | wc -l | tr -d ' ')
no_always_apply=$(find .cursor/rules -name "*.mdc" -exec grep -L "alwaysApply:" {} \; 2>/dev/null | wc -l | tr -d ' ')

echo "### 基本統計"
echo ""
echo "| 項目 | 件数 |"
echo "|------|------|"
echo "| 総.mdcファイル数 | ${total_mdc} |"
echo "| 総.mdファイル数 | ${total_md} |"
echo "| 総ファイル数 | ${total_files} |"
echo "| 常時参照(alwaysApply: true) | ${always_apply_true} |"
echo "| 動的参照(alwaysApply: false) | ${always_apply_false} |"
echo "| 設定なし | ${no_always_apply} |"
echo ""

# パフォーマンス影響度
if [[ $always_apply_true -gt 10 ]]; then
    echo "⚠️ **警告**: 常時参照ファイルが多すぎます (${always_apply_true}個)。パフォーマンスに影響する可能性があります。"
    echo ""
elif [[ $always_apply_true -ge 8 ]]; then
    echo "🔍 **注意**: 常時参照ファイルがやや多めです (${always_apply_true}個)。必要に応じて見直しを検討してください。"
    echo ""
elif [[ $always_apply_true -ge 5 ]]; then
    echo "✅ **良好**: 常時参照ファイル数は適切です (${always_apply_true}個)。"
    echo ""
else
    echo "⚠️ **警告**: 常時参照ファイルが少なすぎる可能性があります (${always_apply_true}個)。必要なルールが不足している可能性があります。"
    echo ""
fi

# ディレクトリ構造
echo "### ディレクトリ構造"
echo ""
echo "\`\`\`"
if command -v tree &> /dev/null; then
    tree .cursor/rules/ -I '__pycache__|*.pyc|.DS_Store' || ls -la .cursor/rules/
else
    find .cursor/rules -type d | sed 's|[^/]*/|  |g' | sed 's|^  ||'
fi
echo "\`\`\`"
echo ""

# エントリーポイント状況
echo "## 🎯 エントリーポイント統制状況"
echo ""

if [[ -f ".cursor/rules/mdc-metadata-manager.mdc" ]]; then
    echo "✅ **エントリーポイント**: 正常に存在"
    
    # エントリーポイントでのプロジェクト名確認
    if [[ -n "$PROJECT_NAME" ]] && grep -q "$PROJECT_NAME" .cursor/rules/mdc-metadata-manager.mdc; then
        echo "✅ **プロジェクト統合**: ${PROJECT_NAME}に適切に設定済み"
    else
        echo "⚠️ **プロジェクト統合**: プロジェクト名の設定を確認してください"
    fi
    
    # alwaysApply設定確認
    if grep -q "alwaysApply: true" .cursor/rules/mdc-metadata-manager.mdc; then
        echo "✅ **参照設定**: 常時参照に正しく設定済み"
    else
        echo "❌ **参照設定**: alwaysApply設定に問題があります"
    fi
else
    echo "❌ **エントリーポイント**: mdc-metadata-manager.mdcが見つかりません"
fi
echo ""

# 必須ファイル状況
echo "## 📁 必須ファイル状況"
echo ""

required_files=(
    ".cursor/rules/mdc-metadata-manager.mdc:エントリーポイント・参照制御"
    ".cursor/rules/mdc-creation-guidelines.mdc:ファイル作成ガイドライン"
    ".cursor/rules/mdc-file-storage-rules.md:格納場所ルール"
    ".cursor/rules/project-starter-kit.mdc:スターターキット"
    ".cursor/rules/core/cursorrules.mdc:Cursor基本動作ルール"
    ".cursor/rules/core/project-overview.mdc:プロジェクト概要"
    ".cursor/rules/core/commit-rules.mdc:Git管理ルール"
    ".cursor/rules/implementation/logging/implementation-log-rules.mdc:実装ログ作成ルール"
    ".cursor/rules/implementation/logging/implementation-log-stock.mdc:実装ログ知識蓄積"
)

echo "| ファイル | 状況 | 説明 |"
echo "|----------|------|------|"

for item in "${required_files[@]}"; do
    file="${item%%:*}"
    desc="${item##*:}"
    
    if [[ -f "$file" ]]; then
        echo "| \`$(basename "$file")\` | ✅ 存在 | $desc |"
    else
        echo "| \`$(basename "$file")\` | ❌ 不足 | $desc |"
    fi
done
echo ""

# プロジェクト固有ルール状況
echo "## 🔧 プロジェクト固有ルール状況"
echo ""

echo "### 技術スタック対応"
echo ""

tech_rules_status=()

# React/Next.js チェック
if [[ "${TECH_STACK,,}" == *"next"* || "${TECH_STACK,,}" == *"react"* ]]; then
    if [[ -f ".cursor/rules/templates/tech-stack/react-nextjs.mdc" ]]; then
        tech_rules_status+=("✅ React/Next.js: 対応ルール存在")
    else
        tech_rules_status+=("❌ React/Next.js: 対応ルール不足")
    fi
fi

# Supabase チェック
if [[ "${TECH_STACK,,}" == *"supabase"* ]]; then
    if [[ -f ".cursor/rules/templates/tech-stack/supabase.mdc" ]]; then
        tech_rules_status+=("✅ Supabase: 対応ルール存在")
    else
        tech_rules_status+=("❌ Supabase: 対応ルール不足")
    fi
fi

# Vue.js チェック
if [[ "${TECH_STACK,,}" == *"vue"* ]]; then
    if [[ -f ".cursor/rules/templates/tech-stack/vue.mdc" ]]; then
        tech_rules_status+=("✅ Vue.js: 対応ルール存在")
    else
        tech_rules_status+=("⚠️ Vue.js: 対応ルール未作成")
    fi
fi

# Node.js チェック
if [[ "${TECH_STACK,,}" == *"node"* ]]; then
    if [[ -f ".cursor/rules/templates/tech-stack/nodejs.mdc" ]]; then
        tech_rules_status+=("✅ Node.js: 対応ルール存在")
    else
        tech_rules_status+=("⚠️ Node.js: 対応ルール未作成")
    fi
fi

if [[ ${#tech_rules_status[@]} -gt 0 ]]; then
    for status in "${tech_rules_status[@]}"; do
        echo "- $status"
    done
else
    echo "- ℹ️ 技術スタック固有ルールの対象技術が検出されませんでした"
fi
echo ""

echo "### チーム構成対応"
echo ""

if [[ -n "$TEAM_SIZE" && -f ".cursor/rules/templates/team-structure/${TEAM_SIZE}-team.mdc" ]]; then
    echo "- ✅ ${TEAM_SIZE}チーム: 対応ルール存在"
else
    echo "- ❌ ${TEAM_SIZE}チーム: 対応ルール不足"
fi
echo ""

# CI/CD統合状況
echo "## 🔄 CI/CD統合状況"
echo ""

if [[ -f ".github/workflows/cursor-rules-check.yml" ]]; then
    echo "✅ **GitHub Actions**: ワークフロー設定済み"
    
    # ワークフローの基本構造チェック
    if grep -q "name:" .github/workflows/cursor-rules-check.yml && \
       grep -q "on:" .github/workflows/cursor-rules-check.yml && \
       grep -q "jobs:" .github/workflows/cursor-rules-check.yml; then
        echo "✅ **ワークフロー構造**: 正常"
    else
        echo "⚠️ **ワークフロー構造**: 構成に問題がある可能性があります"
    fi
    
    # プロジェクト固有設定の確認
    if [[ -n "$PROJECT_NAME" ]] && grep -q "$PROJECT_NAME" .github/workflows/cursor-rules-check.yml; then
        echo "✅ **プロジェクト統合**: ${PROJECT_NAME}に適切に設定済み"
    else
        echo "⚠️ **プロジェクト統合**: プロジェクト名の設定を確認してください"
    fi
else
    echo "❌ **GitHub Actions**: ワークフロー未設定"
    echo ""
    echo "**推奨対応**: 以下のコマンドでワークフローを生成してください:"
    echo "\`\`\`bash"
    echo "./cursor/rules/scripts/cursor-rules-setup.sh"
    echo "\`\`\`"
fi
echo ""

# パフォーマンス分析
echo "## ⚡ パフォーマンス分析"
echo ""

total_size=0
large_files=()
file_count=0

for file in $(find .cursor/rules -name "*.mdc" -o -name "*.md" 2>/dev/null); do
    size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
    total_size=$((total_size + size))
    file_count=$((file_count + 1))
    
    # 50KB以上のファイルを大きなファイルとして記録
    if [[ $size -gt 51200 ]]; then
        large_files+=("$(basename "$file"): $(($size / 1024))KB")
    fi
done

avg_size=$((total_size / file_count))

echo "### ファイルサイズ統計"
echo ""
echo "| 項目 | 値 |"
echo "|------|-----|"
echo "| 総サイズ | $(($total_size / 1024))KB |"
echo "| 平均ファイルサイズ | $(($avg_size / 1024))KB |"
echo "| 大きなファイル数(>50KB) | ${#large_files[@]} |"
echo ""

if [[ ${#large_files[@]} -gt 0 ]]; then
    echo "### 大きなファイル一覧"
    echo ""
    for file in "${large_files[@]}"; do
        echo "- $file"
    done
    echo ""
fi

# パフォーマンス評価
if [[ $total_size -gt 1048576 ]]; then  # 1MB以上
    echo "⚠️ **パフォーマンス**: ルールファイルの総サイズが大きすぎます ($(($total_size / 1024 / 1024))MB)"
    echo "💡 **推奨**: 不要なルールの削除、またはファイル分割を検討してください"
elif [[ $total_size -gt 512000 ]]; then  # 500KB以上
    echo "🔍 **パフォーマンス**: ルールファイルサイズがやや大きめです ($(($total_size / 1024))KB)"
    echo "💡 **推奨**: 定期的なファイルサイズの監視を推奨します"
else
    echo "✅ **パフォーマンス**: ルールファイルサイズは適切です ($(($total_size / 1024))KB)"
fi
echo ""

# セキュリティ状況
echo "## 🛡️ セキュリティ状況"
echo ""

security_issues=0

# 機密情報パターンのチェック
sensitive_patterns=("password" "secret" "token" "api.*key" "private.*key")

for pattern in "${sensitive_patterns[@]}"; do
    found_count=$(grep -ri "$pattern" .cursor/rules/ --include="*.mdc" --include="*.md" 2>/dev/null | wc -l | tr -d ' ')
    if [[ $found_count -gt 0 ]]; then
        echo "⚠️ **機密情報の可能性**: パターン '$pattern' を含むファイル: ${found_count}件"
        security_issues=$((security_issues + found_count))
    fi
done

# プロジェクト設定ファイルのチェック
if [[ -f ".cursor-project-config" ]]; then
    if grep -qi "password\|secret\|token\|key" .cursor-project-config; then
        echo "❌ **重大**: プロジェクト設定ファイルに機密情報が含まれている可能性があります"
        security_issues=$((security_issues + 1))
    fi
fi

if [[ $security_issues -eq 0 ]]; then
    echo "✅ **セキュリティ**: 機密情報の漏洩リスクは検出されませんでした"
else
    echo "⚠️ **セキュリティ**: ${security_issues}件の注意事項があります"
    echo ""
    echo "**推奨対応**:"
    echo "1. 機密情報を含むファイルの確認・修正"
    echo "2. .gitignoreへの適切な設定追加"
    echo "3. 環境変数の活用検討"
fi
echo ""

# 品質スコア算出
echo "## 📊 品質スコア"
echo ""

score=100

# 必須ファイルの不足による減点
missing_required=0
for item in "${required_files[@]}"; do
    file="${item%%:*}"
    if [[ ! -f "$file" ]]; then
        missing_required=$((missing_required + 1))
    fi
done
score=$((score - missing_required * 10))

# alwaysApply設定不備による減点
score=$((score - no_always_apply * 5))

# セキュリティ問題による減点
score=$((score - security_issues * 15))

# パフォーマンス問題による減点
if [[ $total_size -gt 1048576 ]]; then
    score=$((score - 20))
elif [[ $total_size -gt 512000 ]]; then
    score=$((score - 10))
fi

# 技術固有ルール不足による減点
if [[ ${#tech_rules_status[@]} -gt 0 ]]; then
    missing_tech_rules=$(printf '%s\n' "${tech_rules_status[@]}" | grep -c "❌\|⚠️" || echo 0)
    score=$((score - missing_tech_rules * 5))
fi

# スコアの正規化（0-100の範囲に）
if [[ $score -lt 0 ]]; then
    score=0
fi

echo "### 総合品質スコア: ${score}/100"
echo ""

if [[ $score -ge 90 ]]; then
    echo "🎉 **優秀**: Cursorルールシステムは非常に良好です！"
    echo "💡 **推奨**: この品質を維持し、定期的なメンテナンスを継続してください"
elif [[ $score -ge 75 ]]; then
    echo "✅ **良好**: Cursorルールシステムは良い状態です"
    echo "💡 **推奨**: 軽微な改善を行うことでさらに品質が向上します"
elif [[ $score -ge 60 ]]; then
    echo "🔍 **普通**: Cursorルールシステムは基本的な要件を満たしています"
    echo "💡 **推奨**: いくつかの改善項目に取り組むことを推奨します"
elif [[ $score -ge 40 ]]; then
    echo "⚠️ **要改善**: Cursorルールシステムに改善が必要です"
    echo "💡 **推奨**: 必須項目の修正を優先的に行ってください"
else
    echo "❌ **要修正**: Cursorルールシステムに重大な問題があります"
    echo "💡 **推奨**: 包括的な見直しと修正が必要です"
fi

# 改善提案
echo ""
echo "### 改善提案"
echo ""

if [[ $missing_required -gt 0 ]]; then
    echo "1. **必須ファイル作成**: ${missing_required}個の必須ファイルを作成してください"
fi

if [[ $no_always_apply -gt 0 ]]; then
    echo "2. **設定完了**: ${no_always_apply}個のファイルにalwaysApply設定を追加してください"
fi

if [[ $security_issues -gt 0 ]]; then
    echo "3. **セキュリティ強化**: 機密情報の漏洩リスクを確認・修正してください"
fi

if [[ $total_size -gt 512000 ]]; then
    echo "4. **パフォーマンス最適化**: ファイルサイズの削減を検討してください"
fi

tech_missing=$(printf '%s\n' "${tech_rules_status[@]}" | grep -c "❌\|⚠️" || echo 0)
if [[ $tech_missing -gt 0 ]]; then
    echo "5. **技術対応**: ${tech_missing}個の技術固有ルールを作成してください"
fi

echo ""

# フッター
echo "---"
echo ""
echo "**📝 このレポートについて**"
echo ""
echo "- **生成ツール**: Cursor Rules Report Generator"
echo "- **バージョン**: 1.0.0"
echo "- **対象プロジェクト**: ${PROJECT_NAME}"
echo "- **生成日時**: $(date '+%Y年%m月%d日 %H:%M:%S')"
echo ""
echo "**🔄 次回レポート推奨日**: $(date -d '+1 week' '+%Y年%m月%d日')"
echo ""
echo "**💡 改善提案・フィードバック**: プロジェクト管理者まで" 