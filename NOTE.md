HHVM事始め
==========

HHVM(HipHop Virtual Machine)ってなに？
----------

1. HHVMはFacebookが開発・公開しているPHP実行環境
2. プログラミング言語「HACK」を実行するVM
3. PHPも動く


HHVMなにがいいの？
----------

* 速い
* PHPもHACKも動く
  * HACKからPHPのコードが実行できる

速い！
----------

![速い](http://blog.liip.ch/dynimages/370/files/images/blog/hhvm/middle-req.png)

__http://blog.liip.ch/archive/2013/10/29/hhvm-and-symfony2.html__

HACKなにがいいの？
----------

* Type Annotationsで返り値を明示
* まともなラムダ
* Enum
* Tuple（pythonチックだけど上書きできちゃう）
* コンテナ
* etc..

インストール
----------

CentOSに入れてみよう


インストールログ
----------

>  export CMAKE_PREFIX_PATH=/usr
>
>  sudo yum install -y git svn cpp make autoconf automake libtool patch gcc-c++ cmake wget pcre-devel gd-devel libxml2-devel libxslt-devel expat-devel libicu-devel bzip2-devel oniguruma-devel openldap-devel readline-devel libc-client-devel libcap-devel binutils-devel pam-devel elfutils-libelf-devel elfutils-libelf-devel-static libevent-devel libvpx-devel libyaml-devel

>  OLD_GCC_VERSION=$(/usr/bin/gcc --version | egrep '^gcc' | perl -nl -e 'print /([\d+.]+)/')
>  sudo mv /usr/bin/gcc /usr/bin/gcc${OLD_GCC_VERSION}
>  sudo mv /usr/bin/g++ /usr/bin/g++${OLD_GCC_VERSION}
>  sudo mv /usr/bin/c++ /usr/bin/c++${OLD_GCC_VERSION}
> 〜略〜


インストール・・・
----------

CentOSに入れるの超大変


それでもCentOSへ・・・
----------
面倒だから野良レポジトリ使って、必要なもの入れたVagrantがここに！

    % vagrant up


使ってみる
----------

    % vagrant ssh
    % cd /app/www/fib
    % hhvm calc.php

計ってみる
----------

    % time php calc.php 
    102334155
    real  0m44.574s
    user  0m44.408s
    sys 0m0.027s

    % time hhvm calc.php
    102334155
    real  0m2.750s
    user  0m2.711s
    sys 0m0.032s

速い！

アプリで計ってみる
----------

OSSのショッピングカート

    % ab http://php.hhvm.vm/ | grep 'Requests per second'
    Requests per second:    1.79 [#/sec] (mean)

    % ab http://hhvm.vm/ | grep 'Requests per second'
    Requests per second:    0.74 [#/sec] (mean)

あれ？遅い！

アプリで計ってみる
----------

* wordpressとかは速くなるらしい。
* 遅かった理由は調べていない。

結論
----------

使えたければ使えばいいと思う


参考
----------
  * [HHVM](http://hhvm.com/)
  * [HACKリファレンス](http://docs.hhvm.com/manual/en/index.php)
  * [HHVM with Symfony 2 looks amazing](http://blog.liip.ch/archive/2013/10/29/hhvm-and-symfony2.html)
