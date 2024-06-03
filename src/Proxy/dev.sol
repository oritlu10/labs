contract Dev {
        function selectors () external view returns(bytes4, bytes4 , bytes4){
            return(
                Proxy.admin.selector ,
                Proxy.implementation.selector,
                Proxy.upgradeTo. selector
            );
        }

    }
