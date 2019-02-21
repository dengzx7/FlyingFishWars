import ddf.minim.*;//一种控制声音播放的第三方库

Game game;//游戏类，大部分变量和控制函数都放在里面
boolean debug = false;//控制调试与否
void settings()
{
    size(800, 800, P3D);//800x800，P3D模式
    PJOGL.setIcon("resource/icon.png");//程序图标
}
void setup()
{
    surface.setTitle("3D Plane Fight");
    game = new Game(this);
    game.initGame();//初始化游戏
}
//settings()和setup()都是初始化，draw()是每一帧都执行的函数
void draw()
{
    if(debug && !game.pause && game.over == 0)surface.setTitle("3D Plane Fight[fps:" + frameRate + "]");
    game.run();//运行游戏
}
//keyPressed()控制键盘操作
void keyPressed()
{
    if(game.over > 0 || game.pause)return;//游戏结束和暂停的时候都跳过按下操作
    if(key == 65535 && !game.keyCodeStack.contains(keyCode))//控制方向
        game.keyCodeStack.add(keyCode);
    if(key == ' ')//按住空格键开始射击
        game.launch = true;
}
void keyReleased()
{
    if(game.over > 0)
    {
        if(key == ENTER) //游戏结束时，松开回车键重新开始游戏
        {
            game.initGame();
        }
        return;//游戏结束时不能移动也不能暂停游戏
    }
    if(game.over == 0 && (key == 'p' || key == 'P')) //游戏进行时，松开P键暂停或返回游戏
    {
        game.pause = !game.pause;
    }
    if(game.pause)return;//暂停时不能进行移动
    for(int i = game.keyCodeStack.size() - 1; i >= 0; i--)
    {
        if(game.keyCodeStack.get(i) == keyCode) //松开控制方向的键
        {
            game.keyCodeStack.remove(i);
            break;
        }
    }
    if(key == ' ') //松开空格键停止射击
    {
        game.launch = false;
        game.player.launchCount = 0;
    }
}