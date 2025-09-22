#!/data/data/com.termux/files/usr/bin/bash
# سكربت نهائي لإنشاء كل سكربتات NodeTools

mkdir -p ~/NodeTools
cd ~/NodeTools

# 1️⃣ full-node-termux.sh
cat > full-node-termux.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "🔄 تحديث النظام..."
pkg update && pkg upgrade -y
echo "⬇️ تثبيت Node.js LTS و npm..."
pkg install -y nodejs-lts
echo "📦 تثبيت أدوات البناء..."
pkg install -y python make clang binutils pkg-config
echo "🗃️ تثبيت قواعد البيانات المتوفرة..."
pkg install -y postgresql libsqlite
echo "🖼️ تثبيت مكتبات الصور..."
pkg install -y libjpeg-turbo libpng libwebp
echo "✅ الإصدارات:"
node -v
npm -v
echo "🌐 ضبط registry على المرآة السريعة..."
npm config set registry https://registry.npmmirror.com
echo "📂 تنظيف المشروع..."
rm -rf node_modules
rm -f package-lock.json
npm install
echo "🎉 تم إعداد المشروع بالكامل!"
EOF
chmod +x full-node-termux.sh

# 2️⃣ quick-project-setup.sh
cat > quick-project-setup.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "📂 تنظيف المشروع الحالي..."
rm -rf node_modules
rm -f package-lock.json
echo "✅ تم حذف node_modules و package-lock.json"
echo "⬇️ تثبيت الحزم..."
npm install
echo "🎉 تم تجهيز المشروع بالكامل!"
EOF
chmod +x quick-project-setup.sh

# 3️⃣ switch-npm-registry.sh
cat > switch-npm-registry.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "🌐 اختر registry:"
echo "1) المرآة السريعة"
echo "2) الرسمي"
read choice
if [ "$choice" == "1" ]; then
    npm config set registry https://registry.npmmirror.com
    echo "✅ تم التبديل إلى المرآة: $(npm config get registry)"
elif [ "$choice" == "2" ]; then
    npm config set registry https://registry.npmjs.org/
    echo "✅ تم التبديل إلى الرسمي: $(npm config get registry)"
else
    echo "❌ خيار غير صحيح"
fi
EOF
chmod +x switch-npm-registry.sh

# 4️⃣ reset-npm-registry.sh
cat > reset-npm-registry.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
npm config set registry https://registry.npmjs.org/
echo "✅ Registry عاد إلى الرسمي: $(npm config get registry)"
EOF
chmod +x reset-npm-registry.sh

# 5️⃣ إعداد aliases في .bashrc
if ! grep -q "NodeTools aliases" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# NodeTools aliases" >> ~/.bashrc
    echo "alias full-node-termux='$HOME/NodeTools/full-node-termux.sh'" >> ~/.bashrc
    echo "alias quick-node='$HOME/NodeTools/quick-project-setup.sh'" >> ~/.bashrc
    echo "alias switch-reg='$HOME/NodeTools/switch-npm-registry.sh'" >> ~/.bashrc
    echo "alias reset-reg='$HOME/NodeTools/reset-npm-registry.sh'" >> ~/.bashrc
fi

source ~/.bashrc
echo "🎉 تم إنشاء كل السكربتات في NodeTools بنجاح!"
