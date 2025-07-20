#!/bin/bash

# 🔍 Cursor Rules Structure Validation Script
# Cursorルールシステムの構造・整合性をチェック

set -e

# 色付きログ
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }

# 検証開始
echo -e "${BLUE}"
echo "🔍 ============================================="
echo "   Cursor Rules Structure Validation"
echo "   Cursorルール構造・整合性チェック"
echo "=============================================${NC}"
echo ""

# プロジェクト設定読み込み
if [[ -f ".cursor-project-config" ]]; then
    source .cursor-project-config
    log_info "プロジェクト設定読み込み: $PROJECT_NAME"
else
    log_warning "プロジェクト設定ファイルが見つかりません"
    PROJECT_NAME="Unknown Project"
fi

# エラーカウンター
errors=0
warnings=0

# 1. 必須ファイル存在チェック
log_info "必須ファイル存在チェック開始..."

required_files=(
    ".cursor/rules/mdc-metadata-manager.mdc"
    ".cursor/rules/mdc-creation-guidelines.mdc"
    ".cursor/rules/mdc-file-storage-rules.md"
    ".cursor/rules/project-starter-kit.mdc"
    ".cursor/rules/core/cursorrules.mdc"
    ".cursor/rules/core/project-overview.mdc"
    ".cursor/rules/core/commit-rules.mdc"
    ".cursor/rules/implementation/logging/implementation-log-rules.mdc"
    ".cursor/rules/implementation/logging/implementation-log-stock.mdc"
)

for file in "${required_files[@]}"; do
    if [[ ! -f "$file" ]]; then
        log_error "必須ファイルが見つかりません: $file"
        ((errors++))
    else
        echo "  ✓ $file"
    fi
done

if [[ $errors -eq 0 ]]; then
    log_success "必須ファイル存在確認完了"
else
    log_error "必須ファイル不足: $errors 個"
fi

# 2. ディレクトリ構造チェック
log_info "ディレクトリ構造チェック開始..."

required_dirs=(
    ".cursor/rules/core"
    ".cursor/rules/development"
    ".cursor/rules/implementation"
    ".cursor/rules/system"
    ".cursor/rules/templates"
    ".cursor/rules/scripts"
)

for dir in "${required_dirs[@]}"; do
    if [[ ! -d "$dir" ]]; then
        log_warning "推奨ディレクトリが見つかりません: $dir"
        ((warnings++))
    else
        echo "  ✓ $dir"
    fi
done

log_success "ディレクトリ構造チェック完了"

# 3. alwaysApply設定チェック
log_info "alwaysApply設定チェック開始..."

always_apply_true_count=$(grep -r "alwaysApply: true" .cursor/rules/ --include="*.mdc" 2>/dev/null | wc -l)
always_apply_false_count=$(grep -r "alwaysApply: false" .cursor/rules/ --include="*.mdc" 2>/dev/null | wc -l)
no_always_apply_count=$(find .cursor/rules -name "*.mdc" -exec grep -L "alwaysApply:" {} \; 2>/dev/null | wc -l)

echo "  📊 alwaysApply統計:"
echo "    - alwaysApply: true  : $always_apply_true_count ファイル"
echo "    - alwaysApply: false : $always_apply_false_count ファイル"
echo "    - 設定なし          : $no_always_apply_count ファイル"

# alwaysApply: true が多すぎる場合の警告
if [[ $always_apply_true_count -gt 10 ]]; then
    log_warning "alwaysApply: trueが多すぎます ($always_apply_true_count 個)"
    log_warning "パフォーマンスに影響する可能性があります"
    ((warnings++))
fi

# 設定なしファイルの警告
if [[ $no_always_apply_count -gt 0 ]]; then
    log_warning "alwaysApply設定なしファイル: $no_always_apply_count 個"
    echo "  設定なしファイル一覧:"
    find .cursor/rules -name "*.mdc" -exec grep -L "alwaysApply:" {} \; 2>/dev/null | sed 's/^/    - /'
    ((warnings++))
fi

log_success "alwaysApply設定チェック完了"

# 4. Frontmatter完全性チェック
log_info "Frontmatter完全性チェック開始..."

frontmatter_errors=0

for file in $(find .cursor/rules -name "*.mdc" 2>/dev/null); do
    echo "  チェック中: $file"
    
    # description存在チェック
    if ! head -10 "$file" | grep -q "description:" 2>/dev/null; then
        log_error "description不足: $file"
        ((frontmatter_errors++))
    fi
    
    # globs存在チェック
    if ! head -10 "$file" | grep -q "globs:" 2>/dev/null; then
        log_warning "globs不足: $file"
        ((warnings++))
    fi
    
    # alwaysApply存在チェック
    if ! head -10 "$file" | grep -q "alwaysApply:" 2>/dev/null; then
        log_error "alwaysApply不足: $file"
        ((frontmatter_errors++))
    fi
done

if [[ $frontmatter_errors -eq 0 ]]; then
    log_success "Frontmatterチェック完了"
else
    log_error "Frontmatterエラー: $frontmatter_errors 個"
    ((errors+=$frontmatter_errors))
fi

# 5. エントリーポイント整合性チェック
log_info "エントリーポイント整合性チェック開始..."

if [[ -f ".cursor/rules/mdc-metadata-manager.mdc" ]]; then
    # エントリーポイントでプロジェクト名が正しく設定されているかチェック
    if [[ -n "$PROJECT_NAME" ]] && ! grep -q "$PROJECT_NAME" .cursor/rules/mdc-metadata-manager.mdc; then
        log_warning "エントリーポイントにプロジェクト名($PROJECT_NAME)が含まれていません"
        ((warnings++))
    fi
    
    # alwaysApply: trueの設定確認
    if ! grep -q "alwaysApply: true" .cursor/rules/mdc-metadata-manager.mdc; then
        log_error "エントリーポイントのalwaysApply設定が正しくありません"
        ((errors++))
    fi
    
    log_success "エントリーポイント整合性チェック完了"
else
    log_error "エントリーポイントファイルが見つかりません"
    ((errors++))
fi

# 6. プロジェクト固有設定チェック
log_info "プロジェクト固有設定チェック開始..."

if [[ -n "$PROJECT_NAME" && -n "$TECH_STACK" ]]; then
    # 技術スタック固有ルールの存在確認
    tech_rules_found=false
    
    if [[ "${TECH_STACK,,}" == *"next"* || "${TECH_STACK,,}" == *"react"* ]]; then
        if [[ -f ".cursor/rules/templates/tech-stack/react-nextjs.mdc" ]]; then
            tech_rules_found=true
            echo "  ✓ React/Next.js固有ルール存在確認"
        fi
    fi
    
    if [[ "${TECH_STACK,,}" == *"supabase"* ]]; then
        if [[ -f ".cursor/rules/templates/tech-stack/supabase.mdc" ]]; then
            tech_rules_found=true
            echo "  ✓ Supabase固有ルール存在確認"
        fi
    fi
    
    if [[ "$tech_rules_found" == false ]]; then
        log_warning "技術スタック($TECH_STACK)固有ルールが見つかりません"
        ((warnings++))
    fi
    
    # チーム固有ルールの存在確認
    if [[ -n "$TEAM_SIZE" && -f ".cursor/rules/templates/team-structure/${TEAM_SIZE}-team.mdc" ]]; then
        echo "  ✓ ${TEAM_SIZE}チーム固有ルール存在確認"
    else
        log_warning "チーム固有ルール($TEAM_SIZE)が見つかりません"
        ((warnings++))
    fi
    
    log_success "プロジェクト固有設定チェック完了"
else
    log_warning "プロジェクト設定が不完全です"
    ((warnings++))
fi

# 7. GitHub Actions設定チェック
log_info "GitHub Actions設定チェック開始..."

if [[ -f ".github/workflows/cursor-rules-check.yml" ]]; then
    # ワークフローファイルの基本構造チェック
    if grep -q "name:" .github/workflows/cursor-rules-check.yml && \
       grep -q "on:" .github/workflows/cursor-rules-check.yml && \
       grep -q "jobs:" .github/workflows/cursor-rules-check.yml; then
        echo "  ✓ GitHub Actionsワークフロー基本構造確認"
        
        # プロジェクト固有の設定確認
        if [[ -n "$PROJECT_NAME" ]] && grep -q "$PROJECT_NAME" .github/workflows/cursor-rules-check.yml; then
            echo "  ✓ プロジェクト固有設定確認"
        else
            log_warning "GitHub Actionsにプロジェクト固有設定がありません"
            ((warnings++))
        fi
    else
        log_error "GitHub Actionsワークフローの構造が不正です"
        ((errors++))
    fi
    
    log_success "GitHub Actions設定チェック完了"
else
    log_warning "GitHub Actionsワークフローが見つかりません"
    ((warnings++))
fi

# 8. ファイルサイズ・パフォーマンスチェック
log_info "ファイルサイズ・パフォーマンスチェック開始..."

large_files=()
total_size=0

for file in $(find .cursor/rules -name "*.mdc" -o -name "*.md" 2>/dev/null); do
    size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
    total_size=$((total_size + size))
    
    # 100KB以上の大きなファイルを警告
    if [[ $size -gt 102400 ]]; then
        large_files+=("$file ($(($size / 1024))KB)")
        log_warning "大きなファイル: $file ($(($size / 1024))KB)"
        ((warnings++))
    fi
done

echo "  📊 ファイルサイズ統計:"
echo "    - 総サイズ: $((total_size / 1024))KB"
echo "    - 大きなファイル: ${#large_files[@]} 個"

if [[ $total_size -gt 1048576 ]]; then  # 1MB以上
    log_warning "ルールファイルの総サイズが大きすぎます ($(($total_size / 1024 / 1024))MB)"
    ((warnings++))
fi

log_success "ファイルサイズチェック完了"

# 9. セキュリティチェック
log_info "セキュリティチェック開始..."

security_issues=0

# 機密情報のパターンチェック
sensitive_patterns=(
    "password"
    "secret"
    "token"
    "api[_-]?key"
    "private[_-]?key"
)

for pattern in "${sensitive_patterns[@]}"; do
    found_files=$(grep -ri "$pattern" .cursor/rules/ --include="*.mdc" --include="*.md" 2>/dev/null | cut -d: -f1 | sort -u)
    if [[ -n "$found_files" ]]; then
        log_warning "機密情報の可能性: パターン '$pattern' を含むファイル"
        echo "$found_files" | sed 's/^/    - /'
        ((security_issues++))
        ((warnings++))
    fi
done

# .cursor-project-config の機密情報チェック
if [[ -f ".cursor-project-config" ]]; then
    if grep -qi "password\|secret\|token\|key" .cursor-project-config; then
        log_error "プロジェクト設定ファイルに機密情報が含まれている可能性があります"
        ((security_issues++))
        ((errors++))
    fi
fi

if [[ $security_issues -eq 0 ]]; then
    log_success "セキュリティチェック完了 - 問題なし"
else
    log_warning "セキュリティチェック完了 - $security_issues 件の注意事項"
fi

# 10. 最終結果・推奨事項
echo ""
echo -e "${BLUE}📊 ============================================="
echo "   検証結果サマリー"
echo "=============================================${NC}"

if [[ $errors -eq 0 && $warnings -eq 0 ]]; then
    log_success "🎉 Cursorルールシステムは完璧です！"
    echo ""
    echo -e "${GREEN}✅ 全ての検証をパスしました${NC}"
    echo "  - 必須ファイル: 全て存在"
    echo "  - 構造: 正常"
    echo "  - 設定: 適切"
    echo "  - セキュリティ: 問題なし"
elif [[ $errors -eq 0 ]]; then
    log_success "✅ Cursorルールシステムは良好です"
    log_warning "⚠️  改善可能な点: $warnings 件"
    echo ""
    echo -e "${YELLOW}📝 推奨改善事項:${NC}"
    echo "  - 警告項目の確認・修正"
    echo "  - パフォーマンス最適化の検討"
    echo "  - ドキュメントの充実化"
else
    log_error "❌ Cursorルールシステムに問題があります"
    echo ""
    echo -e "${RED}🚨 要修正事項: $errors 件${NC}"
    echo -e "${YELLOW}⚠️  改善事項: $warnings 件${NC}"
    echo ""
    echo -e "${RED}📝 必須修正事項:${NC}"
    echo "  - 必須ファイルの作成・修正"
    echo "  - Frontmatter設定の完了"
    echo "  - エントリーポイントの修正"
    echo "  - セキュリティ問題の解決"
fi

# 終了コード設定
if [[ $errors -gt 0 ]]; then
    exit 1
else
    exit 0
fi 