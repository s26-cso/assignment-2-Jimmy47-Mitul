#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

typedef int (*fptr)(int, int);

int main(){

    char opn[6]; 
    int a,b;
    char lib_name[50];

    while(scanf("%5s %d %d", opn, &a, &b) == 3){

        snprintf(lib_name, sizeof(lib_name), "./lib%s.so", opn);

        void* handle = dlopen(lib_name, RTLD_LAZY);

        if(handle == NULL){
            fprintf(stderr,"Failed to load library: %s\n", dlerror());
            continue; 
        }

        dlerror();

        fptr math_func = (fptr) dlsym(handle, opn);

        char* error = dlerror();
        if(error!=NULL){
            fprintf(stderr,"Failed to find the required opn: %s\n", error);
            dlclose(handle);
            continue;
        }

        int result = math_func(a,b);
  
        printf("%d\n", result);
        dlclose(handle);
        
    }
    return 0;
}