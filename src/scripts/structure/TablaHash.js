var TablaHash = (function () {
    function TablaHash() {
        this.length=0;
        this.items=[];
        this.listItems=[];
        this.listKeys=[];

        this.put=function(key,item){
            //console.log("Se esta agregando "+key);
            this.items[key]=item;
            this.length++;
            this.listItems.push(item);
            this.listKeys.push(key);
            //console.log("Se agrego "+key);
        };
        this.get=function(key){
            return this.containsKey(key) ? this.items[key] : undefined;
        };
        this.containsKey=function(key){
            //console.log("Contains key: "+key+"="+this.items.hasOwnProperty(key));
            return this.items.hasOwnProperty(key)? true:false;
        };
        this.getSize=function(){
            return this.length;
        };
        this.deleteItem=function(key){
            this.length--;
            delete this.items[key];
        };
        this.removeItem=function(key){
            if(this.containsKey(key)){
                item=this.items[key];
                this.length--;
                delete this.items[key];
                return item;
            }
            return undefined;
        };
        this.clear=function(){
            this.items=[];
            this.length=0;
        };
        this.getKeys=function(){
            keys=[];
            for(key in this.items){
                keys.push(key);
            }
            return keys;
        };
        this.getValues=function(){
            values=[];
            for(key in this.items){
                value=this.items[key];
                values.push(value);
            }
            return values;
        };
        this.getItems=function(){
            return this.items;
        };
        this.elementAt=function(index){
            i=0;
            for(key in this.items){
                if(i++ == index){
                    return this.items[key];
                }
            }
            return undefined;
        };
    }
    return TablaHash;
}());
TablaHash["__class"] = "TablaHash";

