#!/bin/bash

# ➤ الانتقال إلى المستودع المركزي
cd ~/nawah-nwtk || exit

echo "📦 بدء تجميع ملفات NWTK في المستودع المركزي..."

# ➤ نسخ العقود الذكية
if [ -d ~/nawah-core/contracts ]; then
  mkdir -p ./contracts
  cp -r ~/nawah-core/contracts/* ./contracts/
  echo "✅ نسخ العقود"
fi

# ➤ نسخ الاختبارات
if [ -d ~/nawah-hardhat/tests ]; then
  mkdir -p ./tests
  cp -r ~/nawah-hardhat/tests/* ./tests/
  echo "✅ نسخ الاختبارات"
fi

# ➤ نسخ الوثائق
if [ -d ~/nawah-nwtk/docs ]; then
  mkdir -p ./docs
  cp -r ~/nawah-nwtk/docs/* ./docs/
  echo "✅ نسخ الوثائق"
fi

# ➤ نسخ السكربتات
if [ -d ~/my-scripts ]; then
  mkdir -p ./scripts
  cp -r ~/my-scripts/* ./scripts/
  echo "✅ نسخ السكربتات"
fi

# ➤ إنشاء الملفات الأساسية إذا لم تكن موجودة
mkdir -p ./docs
[ ! -f docs/SECURITY.md ] && echo -e "# SECURITY.md\n\n## Ownership & Transparency\n- Project Owner: nawahtkui\n- Last Updated: $(date +%Y-%m-%d)" > docs/SECURITY.md
[ ! -f docs/Tokenomics.md ] && echo -e "# Tokenomics\n\nTotal Supply: 100,000,000 NWTK\n\nDistribution:\n- Team: 10,000,000\n- Ecosystem: 20,000,000\n- Public Sale: 50,000,000\n- Reserves: 20,000,000" > docs/Tokenomics.md

# ➤ إضافة الملفات إلى Git
git add .
git commit -m "Merge all NWTK files into central repository"

# ➤ ربط المستودع بـ SSH والتأكد من الرابط
git remote set-url origin git@github.com:nawahtkui/nawah-nwtk.git
echo "🔗 Remote repository set to:"
git remote -v

# ➤ اختبار اتصال SSH
ssh -T git@github.com || { echo "❌ SSH authentication failed"; exit 1; }

# ➤ رفع الملفات إلى GitHub
git push -u origin main && echo "🎉 تم رفع جميع الملفات إلى GitHub بنجاح!"

