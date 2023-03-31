class Cuenta{
  String nombre;
  int saldo;
  
  Cuenta(String cliente_, int deposito_){
    nombre = cliente_;
    saldo = deposito_;
  }
  
  int saldo(){
    return saldo;
  }
  
  void deposito(int t_){
    saldo+=t_;
  }
  
  int retiro( int t_){
    int dinero = 0;
    if(t_<saldo){
      dinero = t_;
      saldo -= t_;
    }
    return dinero;
  }  
  
  int retiroExt( int t_,int comision_){
    int dinero = 0;
    if(t_+comision_<saldo){
      dinero = t_;
      saldo -= t_;
      saldo -= comision_;
    }
    return dinero;
  }  
}


void setup(){
  Cuenta una;
  una = new Cuenta("Benjamín", 2000);
  println(una.saldo());
  println(una.retiro(500));
  println(una.saldo());
  una.deposito(300);
  println(una.retiroExt(500,20));
  println(una.saldo());
}
